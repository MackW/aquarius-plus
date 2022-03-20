#include "video.h"
#include "emustate.h"

static uint16_t screen[VIDEO_WIDTH * VIDEO_HEIGHT];

const uint16_t *video_get_fb(void) {
    return screen;
}

enum {
    VCTRL_TEXT_ENABLE    = (1 << 0),
    VCTRL_MODE_OFF       = (0 << 1),
    VCTRL_MODE_TILEMAP   = (1 << 1),
    VCTRL_MODE_BITMAP    = (2 << 1),
    VCTRL_MODE_MASK      = (3 << 1),
    VCTRL_SPRITES_ENABLE = (1 << 3),
    VCTRL_TEXT_PRIORITY  = (1 << 4),
};

void video_draw_line(void) {
    int line = emustate.video_line;
    if (line < 0 || line >= VIDEO_HEIGHT)
        return;

    // Render text
    uint8_t  line_text[512];
    unsigned idx = 512 - 16;

    bool vactive = line >= 16 && line < 216;

    for (int i = 0; i < VIDEO_WIDTH; i++) {
        // Draw text character
        uint8_t ch;
        uint8_t color;
        if (vactive && idx < 320) {
            int row    = (line - 16) / 8;
            int column = (i - 16) / 8;
            ch         = emustate.screenram[row * 40 + column];
            color      = emustate.colorram[row * 40 + column];
        } else {
            ch    = emustate.screenram[0];
            color = emustate.colorram[0];
        }

        uint8_t charbm = emustate.charram[ch * 8 + (line & 7)];
        line_text[idx] = (charbm & (1 << (7 - (i & 7)))) ? (color >> 4) : (color & 0xF);
        idx            = (idx + 1) & 511;
    }

    // Render bitmap/tile layer
    uint8_t line_bitmap[512];
    if (vactive) {
        int bmline = line - 16;
        switch (emustate.video_ctrl & VCTRL_MODE_MASK) {
            case VCTRL_MODE_BITMAP: {
                // Bitmap mode
                for (int i = 0; i < 320; i++) {
                    int     row    = bmline / 8;
                    int     column = i / 8;
                    uint8_t col    = emustate.videoram[0x2000 + row * 40 + column];
                    uint8_t bm     = emustate.videoram[0x0000 + bmline * 40 + column];
                    uint8_t color  = (bm & (1 << (7 - (i & 7)))) ? (col >> 4) : (col & 0xF);

                    line_bitmap[i] = (1 << 4) | color;
                }
                break;
            }

            case VCTRL_MODE_TILEMAP: {
                // Tile mode
                idx            = (-(emustate.video_scrx & 7)) & 511;
                unsigned tline = (bmline + emustate.video_scry) & 255;
                unsigned row   = (tline >> 3) & 31;
                unsigned col   = emustate.video_scrx >> 3;

                for (int i = 0; i < 41; i++) {
                    // Tilemap is 64x32 (2 bytes per entry)

                    // Fetch tilemap entry
                    uint8_t entry_l = emustate.videoram[(row << 7) | (col << 1)];
                    uint8_t entry_h = emustate.videoram[(row << 7) | (col << 1) | 1];

                    unsigned tile_idx = ((entry_h & 1) << 8) | entry_l;
                    bool     hflip    = (entry_h & (1 << 1)) != 0;
                    bool     vflip    = (entry_h & (1 << 2)) != 0;
                    uint8_t  attr     = entry_h & 0x70;

                    unsigned pat_offs = (tile_idx << 5) | ((tline & 7) << 2);
                    if (vflip)
                        pat_offs ^= (7 << 2);

                    // Next column
                    col = (col + 1) & 63;

                    for (int n = 0; n < 4; n++) {
                        int m = n;
                        if (hflip)
                            m ^= 3;

                        uint8_t data = emustate.videoram[pat_offs + m];

                        if (!hflip) {
                            line_bitmap[idx++] = (data >> 4) | attr;
                            idx &= 511;
                        }
                        line_bitmap[idx++] = (data & 0xF) | attr;
                        idx &= 511;
                        if (hflip) {
                            line_bitmap[idx++] = (data >> 4) | attr;
                            idx &= 511;
                        }
                    }
                }
                break;
            }

            default: {
                for (int i = 0; i < 320; i++) {
                    line_bitmap[i] = 0;
                }
                break;
            }
        }

        // Render sprites
        if ((emustate.video_ctrl & (1 << 3)) != 0) {
            for (int i = 0; i < 64; i++) {
                unsigned sprattr = emustate.video_sprattr[i];

                // Check if sprite enabled
                bool enabled = (sprattr & (1 << 7)) != 0;
                if (!enabled)
                    continue;

                // Check if sprite is visible on this line
                int height  = (sprattr & (1 << 3)) != 0 ? 16 : 8;
                int sprline = (bmline - emustate.video_spry[i]) & 0xFF;
                if (sprline >= height)
                    continue;

                int      sprx     = emustate.video_sprx[i];
                unsigned tile_idx = emustate.video_spridx[i];
                bool     hflip    = (sprattr & (1 << 1)) != 0;
                bool     vflip    = (sprattr & (1 << 2)) != 0;
                uint8_t  palette  = sprattr & 0x30;
                bool     priority = (sprattr & (1 << 6)) != 0;

                idx = sprx;

                if (vflip)
                    sprline ^= 7;

                unsigned pat_offs = (tile_idx << 5) | (sprline << 2);
                if (vflip)
                    pat_offs ^= (7 << 2);

                for (int n = 0; n < 4; n++) {
                    int m = n;
                    if (hflip)
                        m ^= 3;

                    uint8_t data = emustate.videoram[pat_offs + m];

                    if (!hflip) {
                        if (priority || (line_bitmap[idx] & (1 << 6)) == 0) {
                            unsigned colidx = (data >> 4);

                            if (colidx != 0)
                                line_bitmap[idx++] = colidx | palette;
                            idx &= 511;
                        }
                    }
                    if (priority || (line_bitmap[idx] & (1 << 6)) == 0) {
                        unsigned colidx = (data & 0xF);

                        if (colidx != 0)
                            line_bitmap[idx++] = colidx | palette;
                        idx &= 511;
                    }
                    if (hflip) {
                        if (priority || (line_bitmap[idx] & (1 << 6)) == 0) {
                            unsigned colidx = (data >> 4);

                            if (colidx != 0)
                                line_bitmap[idx++] = colidx | palette;
                            idx &= 511;
                        }
                    }
                }
            }
        }
    }

    // Compose layers
    uint16_t *pd = &screen[line * VIDEO_WIDTH];
    idx          = 512 - 16;

    for (int i = 0; i < VIDEO_WIDTH; i++) {
        bool active = idx < 320 && vactive;

        bool text_priority = (emustate.video_ctrl & VCTRL_TEXT_PRIORITY) != 0;
        bool text_enable   = (emustate.video_ctrl & VCTRL_TEXT_ENABLE) != 0;

        uint8_t colidx = 0;
        if (text_enable) {
            colidx = line_text[idx];
        }
        if (active) {
            uint8_t bm_colidx    = line_bitmap[idx];
            bool    render_pixel = (bm_colidx & 0xF) != 0;

            if (text_priority && (colidx & 0xF) != 0) {
                render_pixel = false;
            }
            if (render_pixel) {
                colidx = bm_colidx;
            }
        }

        pd[i] = emustate.video_palette[colidx & 0x3F];

        idx = (idx + 1) & 511;
    }
}
