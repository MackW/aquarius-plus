#include "FileServer.h"
#include <esp_http_server.h>
#include <sys/unistd.h>
#include <sys/stat.h>
#include "SDCardVFS.h"
#include <errno.h>
#include <mdns.h>
#include "AqKeyboard.h"
#include "FPGA.h"
#include "SDCardVFS.h"

typedef union {
    struct {
        uint16_t mday : 5; /* Day of month, 1 - 31 */
        uint16_t mon : 4;  /* Month, 1 - 12 */
        uint16_t year : 7; /* Year, counting from 1980. E.g. 37 for 2017 */
    };
    uint16_t as_int;
} fat_date_t;

typedef union {
    struct {
        uint16_t sec : 5;  /* Seconds divided by 2. E.g. 21 for 42 seconds */
        uint16_t min : 6;  /* Minutes, 0 - 59 */
        uint16_t hour : 5; /* Hour, 0 - 23 */
    };
    uint16_t as_int;
} fat_time_t;

static const char *TAG = "FileServer";

static esp_err_t serverError(httpd_req_t *req) {
    httpd_resp_send_err(req, HTTPD_500_INTERNAL_SERVER_ERROR, "Internal server error.");
    return ESP_OK;
}

static esp_err_t resp404(httpd_req_t *req) {
    httpd_resp_send_404(req);
    return ESP_OK;
}

static esp_err_t resp204(httpd_req_t *req) {
    httpd_resp_set_status(req, HTTPD_204);
    httpd_resp_send(req, nullptr, 0);
    return ESP_OK;
}

FileServer::FileServer() {
    server = nullptr;
}

FileServer &FileServer::instance() {
    static FileServer obj;
    return obj;
}

void FileServer::init() {
    esp_err_t err = mdns_init();
    if (err != ESP_OK) {
        ESP_LOGE(TAG, "MDNS Init failed: %d\n", err);
    } else {
        mdns_hostname_set(CONFIG_LWIP_LOCAL_HOSTNAME);
        mdns_instance_name_set("Aquarius+");
    }

    httpd_config_t config   = HTTPD_DEFAULT_CONFIG();
    config.max_uri_handlers = 10;
    config.uri_match_fn     = httpd_uri_match_wildcard;

    ESP_LOGI(TAG, "Starting HTTP Server on port: '%d'", config.server_port);
    if (httpd_start(&server, &config) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to start file server!");
        return;
    }

    registerHandler("/keyboard", HTTP_POST, [&](httpd_req_t *req) { return postKeyboard(req); });
    registerHandler("/sysrom", HTTP_POST, [&](httpd_req_t *req) { return postSysRom(req); });
    registerHandler("/*", HTTP_DELETE, [&](httpd_req_t *req) { return handleDelete(req); });
    registerHandler("/*", HTTP_GET, [&](httpd_req_t *req) { return handleGet(req); });
    registerHandler("/*", HTTP_PUT, [&](httpd_req_t *req) { return handlePut(req); });
    registerHandler("/*", HTTP_COPY, [&](httpd_req_t *req) { return handleCopy(req); });
    registerHandler("/*", HTTP_MKCOL, [&](httpd_req_t *req) { return handleMkCol(req); });
    registerHandler("/*", HTTP_MOVE, [&](httpd_req_t *req) { return handleMove(req); });
    registerHandler("/*", HTTP_OPTIONS, [&](httpd_req_t *req) { return handleOptions(req); });
    registerHandler("/*", HTTP_PROPFIND, [&](httpd_req_t *req) { return handlePropFind(req); });
}

esp_err_t FileServer::_handler(httpd_req_t *req) {
    auto ctx = static_cast<HandlerContext *>(req->user_ctx);
    return ctx->handler(req);
}

void FileServer::registerHandler(const std::string &uri, httpd_method_t method, HttpHandler handler) {
    auto ctx     = new HandlerContext;
    ctx->handler = handler;

    httpd_uri_t hu = {.uri = uri.c_str(), .method = method, .handler = _handler, .user_ctx = ctx};
    httpd_register_uri_handler(server, &hu);
}

static std::string urlEncode(const std::string &s) {
    std::string result;
    const char  hexlut[] = "0123456789ABCDEF";

    for (auto ch : s) {
        if ((ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9') ||
            (ch == '_' || ch == '-' || ch == '.' || ch == '/')) {
            result.push_back(ch);
        } else {
            result.push_back('%');
            result.push_back(hexlut[ch >> 4]);
            result.push_back(hexlut[ch & 15]);
        }
    }
    return result;
}

static std::string urlDecode(const std::string &s) {
    std::string result;
    const char *ps = s.c_str();

    while (*ps != '\0') {
        char ch = *(ps++);

        if (ch == '%') {
            ch = 0;
            for (int i = 0; i < 2; i++) {
                uint8_t tmp = *(ps++);
                if (tmp >= '0' && tmp <= '9')
                    tmp -= '0';
                else if (tmp >= 'a' && tmp <= 'z')
                    tmp = tmp - 'a' + 10;
                else if (tmp >= 'A' && tmp <= 'Z')
                    tmp = tmp - 'A' + 10;
                else
                    break;

                ch = (ch << 4) | tmp;
            }
        }
        result.push_back(ch);
    }
    return result;
}

static std::string getPathFromUri(const std::string &uri) {
    return urlDecode(uri.substr(0, std::min(uri.size(), uri.find_first_of("?#"))));
}

esp_err_t FileServer::handleOptions(httpd_req_t *req) {
    httpd_resp_set_hdr(req, "DAV", "1");
    httpd_resp_set_hdr(
        req, "Allow",
        "OPTIONS, "  // Done
        "PROPFIND, " // Done
        // "PROPPATCH, "
        "MKCOL, " // Done
        "GET, "   // Done
        // "HEAD, "
        "POST, "
        "DELETE, " // Done
        "PUT, "    // Done
        "COPY, "   // Done
        "MOVE"     // Done
    );
    return resp204(req);
}

static void propfind_st(httpd_req_t *req, const char *href_tag, const struct stat *st) {
    char tmp[128];

    httpd_resp_sendstr_chunk(req, "<response>");
    httpd_resp_sendstr_chunk(req, href_tag);
    httpd_resp_sendstr_chunk(req, "<propstat><prop>");

    if (S_ISDIR(st->st_mode)) {
        httpd_resp_sendstr_chunk(req, "<resourcetype><collection/></resourcetype>");
    } else {
        httpd_resp_sendstr_chunk(req, "<resourcetype/>");

        snprintf(tmp, sizeof(tmp), "<getcontentlength>%lu</getcontentlength>", st->st_size);
        httpd_resp_sendstr_chunk(req, tmp);
    }

    struct tm tm;
    localtime_r(&st->st_mtim.tv_sec, &tm);
    char strftime_buf[64];
    strftime(strftime_buf, sizeof(strftime_buf), "%a, %d %b %Y %T %z", &tm);
    snprintf(tmp, sizeof(tmp), "<getlastmodified>%s</getlastmodified>", strftime_buf);
    httpd_resp_sendstr_chunk(req, tmp);

    httpd_resp_sendstr_chunk(req, "</prop><status>HTTP/1.1 200 OK</status></propstat></response>");
}

esp_err_t FileServer::handlePropFind(httpd_req_t *req) {
    // Get hostname in request header
    char host[64];
    if (httpd_req_get_hdr_value_str(req, "Host", host, sizeof(host)) != ESP_OK)
        return ESP_FAIL;

    // Get depth
    char depth[16] = "0";
    httpd_req_get_hdr_value_str(req, "Depth", depth, sizeof(depth));

    // Get payload
    const size_t tmpSize = 1024;
    auto         tmp     = std::make_unique<char[]>(tmpSize);
    int          size    = httpd_req_recv(req, tmp.get(), tmpSize - 1);
    if (size > 0) {
        tmp.get()[size] = '\0';
    }

    // Get path
    auto uriPath = getPathFromUri(req->uri);

    // ESP_LOGI(TAG, "PROPFIND: %s", path);

    httpd_resp_set_hdr(req, "DAV", "1");

    auto &vfs = SDCardVFS::instance();

    // Check file
    struct stat st;
    if (vfs.stat(uriPath, &st) != 0)
        return resp404(req);

    httpd_resp_set_type(req, "text/xml; encoding=\"utf-8\"");
    httpd_resp_set_status(req, HTTPD_207);
    httpd_resp_sendstr_chunk(req, "<?xml version=\"1.0\" encoding=\"utf-8\"?>");
    httpd_resp_sendstr_chunk(req, "<multistatus xmlns=\"DAV:\">");

    snprintf(tmp.get(), tmpSize, "<href>http://%s%s</href>", host, urlEncode(uriPath).c_str());
    propfind_st(req, tmp.get(), &st);

    if (S_ISDIR(st.st_mode) && depth[0] != '0') {
        auto deCtx = vfs.direnum(uriPath);
        if (!deCtx)
            return serverError(req);
        deCtx->push_back(DirEnumEntry("..", 0, DE_DIR, 0, 0));

        std::sort(deCtx->begin(), deCtx->end(), [](auto &a, auto &b) {
            // Sort directories at the top
            if ((a.attr & DE_DIR) != (b.attr & DE_DIR)) {
                return (a.attr & DE_DIR) != 0;
            }
            return strcasecmp(a.filename.c_str(), b.filename.c_str()) < 0;
        });

        for (auto &de : *deCtx) {
            snprintf(tmp.get(), tmpSize, "<href>http://%s%s%s</href>", host, uriPath.c_str(), urlEncode(de.filename).c_str());

            memset(&st, 0, sizeof(st));
            st.st_size = de.size;
            st.st_mode = S_IRWXU | S_IRWXG | S_IRWXO | ((de.attr & DE_DIR) != 0 ? S_IFDIR : S_IFREG);

            fat_date_t fdate = {.as_int = de.fdate};
            fat_time_t ftime = {.as_int = de.ftime};

            struct tm tm;
            memset(&tm, 0, sizeof(tm));
            tm.tm_mday  = fdate.mday,
            tm.tm_mon   = fdate.mon - 1,
            tm.tm_year  = fdate.year + 80,
            tm.tm_sec   = ftime.sec * 2,
            tm.tm_min   = ftime.min,
            tm.tm_hour  = ftime.hour,
            tm.tm_isdst = -1;

            st.st_mtime = mktime(&tm);
            st.st_atime = 0;
            st.st_ctime = 0;

            propfind_st(req, tmp.get(), &st);
        }
    }
    httpd_resp_sendstr_chunk(req, "</multistatus>");
    httpd_resp_sendstr_chunk(req, nullptr);
    return ESP_OK;
}

esp_err_t FileServer::handleDelete(httpd_req_t *req) {
    auto &vfs = SDCardVFS::instance();

    int result = vfs.delete_(getPathFromUri(req->uri));
    if (result == ERR_NOT_FOUND) {
        return resp404(req);
    } else if (result != 0) {
        return serverError(req);
    }
    return resp204(req);
}

esp_err_t FileServer::handleGet(httpd_req_t *req) {
    // Allocate buffers
    const size_t tmpSize = 16384;
    auto         tmp     = std::make_unique<char[]>(tmpSize);

    // Get path
    auto uriPath = getPathFromUri(req->uri);
    if (uriPath.empty() || uriPath.back() != '/')
        uriPath += '/';

    auto &vfs = SDCardVFS::instance();

    struct stat st;
    if (vfs.stat(uriPath, &st) != 0)
        return resp404(req);

    if (S_ISDIR(st.st_mode)) {
        auto deCtx = vfs.direnum(uriPath);
        if (!deCtx)
            return serverError(req);
        deCtx->push_back(DirEnumEntry("..", 0, DE_DIR, 0, 0));

        std::sort(deCtx->begin(), deCtx->end(), [](auto &a, auto &b) {
            // Sort directories at the top
            if ((a.attr & DE_DIR) != (b.attr & DE_DIR)) {
                return (a.attr & DE_DIR) != 0;
            }
            return strcasecmp(a.filename.c_str(), b.filename.c_str()) < 0;
        });

        httpd_resp_set_type(req, "text/html; charset=utf-8");

        httpd_resp_sendstr_chunk(req, "<!DOCTYPE html><html><body>");
        httpd_resp_sendstr_chunk(
            req,
            "<table class=\"fixed\" border=\"1\">"
            "<thead><tr><th>Name</th><th align=\"right\">Size (Bytes)</th></tr></thead>"
            "<tbody>");

        for (auto &de : *deCtx) {
            snprintf(tmp.get(), tmpSize, "<tr><td><a href=\"%s\">%s</href></td>", urlEncode(uriPath + de.filename).c_str(), de.filename.c_str());
            httpd_resp_sendstr_chunk(req, tmp.get());

            if (de.attr & DE_DIR) {
                snprintf(tmp.get(), tmpSize, "<td align=\"right\">Directory</td></tr>");
            } else {
                snprintf(tmp.get(), tmpSize, "<td align=\"right\">%lu</td></tr>", de.size);
            }
            httpd_resp_sendstr_chunk(req, tmp.get());
        }

        httpd_resp_sendstr_chunk(req, "</tbody></table>");
        httpd_resp_sendstr_chunk(req, "</body></html>");
        httpd_resp_sendstr_chunk(req, nullptr);

    } else {
        int fd = vfs.open(FO_RDONLY, uriPath);
        if (fd < 0) {
            return resp404(req);
        } else {
            httpd_resp_set_type(req, "application/octet-stream");
            while (1) {
                int size = vfs.read(fd, tmpSize, tmp.get());
                if (size < 0)
                    break;

                httpd_resp_send_chunk(req, tmp.get(), size);
                if (size == 0) {
                    break;
                }
            }
            vfs.close(fd);
        }
    }
    return ESP_OK;
}

esp_err_t FileServer::handlePut(httpd_req_t *req) {
    // Allocate buffers
    const size_t tmpSize = 16384;
    auto         tmp     = std::make_unique<char[]>(tmpSize);

    // printf("PUT %s\n", path);

    auto &vfs = SDCardVFS::instance();

    auto path = getPathFromUri(req->uri);

    // Open target file
    int fd = vfs.open(FO_WRONLY | FO_CREATE, path);
    if (fd < 0) {
        return serverError(req);
    }

    auto remaining = req->content_len;
    while (remaining > 0) {
        // ESP_LOGI(TAG, "Remaining size : %d", remaining);
        // Receive the file part by part into a buffer
        int received;
        if ((received = httpd_req_recv(req, tmp.get(), std::min(remaining, tmpSize))) <= 0) {
            if (received == HTTPD_SOCK_ERR_TIMEOUT) {
                // Retry if timeout occurred
                continue;
            }

            // In case of unrecoverable error, close and delete the unfinished file
            vfs.close(fd);
            vfs.delete_(path);
            return serverError(req);
        }

        // Write buffer content to file on storage
        if (received && (received != vfs.write(fd, received, tmp.get()))) {
            // Couldn't write everything to file! Storage may be full?
            vfs.close(fd);
            vfs.delete_(path);
            return serverError(req);
        }

        // Keep track of remaining size of the file left to be uploaded
        remaining -= received;
    }
    vfs.close(fd);

    return resp204(req);
}

esp_err_t FileServer::handleMove(httpd_req_t *req) {
    // Allocate buffers
    const size_t tmpSize = 1024;
    auto         tmp     = std::make_unique<char[]>(tmpSize);

    // Get path
    auto path = getPathFromUri(req->uri);

    // Get destination path from request header
    if (httpd_req_get_hdr_value_str(req, "Destination", tmp.get(), tmpSize) != ESP_OK)
        return serverError(req);

    char host[64];
    if (httpd_req_get_hdr_value_str(req, "Host", host, sizeof(host)) != ESP_OK)
        return serverError(req);

    char *p = strcasestr(tmp.get(), host);
    if (p == nullptr || p - tmp.get() > 8)
        return resp404(req);
    p += strlen(host);

    auto path2 = urlDecode(p);
    // printf("MOVE %s to %s\n", path, path2);

    // Do rename
    auto &vfs = SDCardVFS::instance();
    if (vfs.rename(path, path2) < 0) {
        return resp404(req);
    }
    return resp204(req);
}

esp_err_t FileServer::handleMkCol(httpd_req_t *req) {
    // Unlink file
    auto &vfs = SDCardVFS::instance();
    if (vfs.mkdir(getPathFromUri(req->uri)) < 0) {
        return serverError(req);
    }
    return resp204(req);
}

esp_err_t FileServer::handleCopy(httpd_req_t *req) {
    // Allocate buffers
    const size_t tmpSize = 16384;
    auto         tmp     = std::make_unique<char[]>(tmpSize);

    // Get path
    auto path = getPathFromUri(req->uri);

    // Get destination path from request header
    if (httpd_req_get_hdr_value_str(req, "Destination", tmp.get(), tmpSize) != ESP_OK)
        return serverError(req);

    char host[64];
    if (httpd_req_get_hdr_value_str(req, "Host", host, sizeof(host)) != ESP_OK)
        return serverError(req);

    char *p = strcasestr(tmp.get(), host);
    if (p == nullptr || p - tmp.get() > 8)
        return resp404(req);
    p += strlen(host);

    auto path2 = urlDecode(p);

    if (path == path2)
        return resp204(req);

    // printf("COPY %s to %s\n", path, path2);
    auto &vfs = SDCardVFS::instance();
    int   fd  = vfs.open(FO_RDONLY, path);
    if (fd < 0)
        return resp404(req);
    int fd2 = vfs.open(FO_CREATE | FO_WRONLY, path2);
    if (fd2 < 0) {
        vfs.close(fd);
        return resp404(req);
    }

    while (1) {
        int size = vfs.read(fd, tmpSize, tmp.get());
        if (size <= 0)
            break;

        if (vfs.write(fd2, size, tmp.get()) != size) {
            vfs.close(fd);
            vfs.close(fd2);
            vfs.delete_(path2);
            return serverError(req);
        }
    }
    vfs.close(fd);
    vfs.close(fd2);

    return resp204(req);
}

esp_err_t FileServer::postKeyboard(httpd_req_t *req) {
    // Allocate buffers
    const size_t tmpSize = 16384;
    auto         tmp     = std::make_unique<char[]>(tmpSize);

    auto remaining = req->content_len;
    while (remaining > 0) {
        // ESP_LOGI(TAG, "Remaining size : %d", remaining);
        // Receive the file part by part into a buffer
        int received;
        if ((received = httpd_req_recv(req, tmp.get(), std::min(remaining, tmpSize))) <= 0) {
            if (received == HTTPD_SOCK_ERR_TIMEOUT) {
                // Retry if timeout occurred
                continue;
            }
            return serverError(req);
        }

        // Write buffer to keyboard
        auto &kb = AqKeyboard::instance();
        for (unsigned i = 0; i < received; i++) {
            kb.pressKey(tmp[i]);
        }

        // Keep track of remaining size of the file left to be uploaded
        remaining -= received;
    }
    return resp204(req);
}

esp_err_t FileServer::postSysRom(httpd_req_t *req) {
    // Allocate buffers
    const size_t tmpSize = 16384;
    auto         tmp     = std::make_unique<char[]>(tmpSize);

    auto remaining = req->content_len;
    if (req->content_len > 40 * 1024) {
        return serverError(req);
    }

    auto &fpga = FPGA::instance();
    fpga.aqpAqcuireBus();

    uint16_t addr = 0;

    bool error = false;

    while (remaining > 0) {
        // ESP_LOGI(TAG, "Remaining size : %d", remaining);
        // Receive the file part by part into a buffer
        int received;
        if ((received = httpd_req_recv(req, tmp.get(), std::min(remaining, tmpSize))) <= 0) {
            if (received == HTTPD_SOCK_ERR_TIMEOUT) {
                // Retry if timeout occurred
                continue;
            }
            // In case of unrecoverable error, close and delete the unfinished file
            error = true;
            break;
        }

        // Write buffer content to file on storage
        for (int i = 0; i < received; i++) {
            fpga.aqpWriteROM(addr++, tmp[i]);
        }

        // Keep track of remaining size of the file left to be uploaded
        remaining -= received;
    }

    while (addr < 40 * 1024) {
        fpga.aqpWriteROM(addr++, 0xFF);
    }
    fpga.aqpReleaseBus();
    fpga.aqpReset();

    if (error)
        return serverError(req);

    return resp204(req);
}
