#include "terminal.h"
#include <string.h>

#define COLUMNS 80
#define ROWS    24

#define TEXT_RAM ((uint8_t *)0x3000 + COLUMNS)

static uint8_t *text_p;
static uint8_t  text_x;
static uint8_t  text_y;
static uint8_t  text_color;
static uint8_t  escape_idx = 0;
static uint8_t  escape_cmd[16];
static uint8_t  attributes = 0;
static uint8_t  fg_col     = 7;
static uint8_t  bg_col     = 0;
static char    *cmd_params;

static void clear_display(int n);

void terminal_init(void) {
    IO_VCTRL           = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    *(TEXT_RAM + 2047) = 0;

    text_x     = 0;
    text_y     = 0;
    text_color = 0x70;
    text_p     = TEXT_RAM;

    clear_display(2);
}

static void clear_display(int n) {
    IO_VCTRL = VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    if (n == 0) {
        // Clear from cursor to end of screen
        memset(text_p, ' ', (TEXT_RAM + ROWS * COLUMNS) - text_p);
    } else if (n == 1) {
        // Clear from cursor to beginning of the screen
        memset(TEXT_RAM, ' ', text_p - TEXT_RAM);
    } else {
        // Clear entire screen
        memset(TEXT_RAM, ' ', ROWS * COLUMNS);
    }

    IO_VCTRL = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    if (n == 0) {
        // Clear from cursor to end of screen
        memset(text_p, text_color, (TEXT_RAM + ROWS * COLUMNS) - text_p);
    } else if (n == 1) {
        // Clear from cursor to beginning of the screen
        memset(TEXT_RAM, text_color, text_p - TEXT_RAM);
    } else {
        // Clear entire screen
        memset(TEXT_RAM, text_color, ROWS * COLUMNS);
    }
}

static void clear_line(int n) {
    IO_VCTRL = VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    if (n == 0) {
        // Clear from cursor to end of line
        memset(text_p, ' ', COLUMNS - text_x);
    } else if (n == 1) {
        // Clear from cursor to beginning of the line
        memset(TEXT_RAM + text_y * COLUMNS, ' ', text_x);
    } else {
        // Clear entire line
        memset(TEXT_RAM + text_y * COLUMNS, ' ', COLUMNS);
    }

    IO_VCTRL = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    if (n == 0) {
        // Clear from cursor to end of line
        memset(text_p, text_color, COLUMNS - text_x);
    } else if (n == 1) {
        // Clear from cursor to beginning of the line
        memset(TEXT_RAM + text_y * COLUMNS, text_color, text_x);
    } else {
        // Clear entire line
        memset(TEXT_RAM + text_y * COLUMNS, text_color, COLUMNS);
    }
}

static void insert_line(int n) {
    if (n < 1)
        return;
    if (n > ROWS)
        n = ROWS;

    // FIXME!!!

    // Inserts <n> lines into the buffer at the cursor position. The line the cursor is on, and lines below it, will be shifted downwards.
    // uint8_t *from = TEXT_RAM + COLUMNS * text_y;
    // uint8_t *to   = TEXT_RAM + COLUMNS * (text_y + n);
    // int      size = COLUMNS * (ROWS - text_y);

    // IO_VCTRL = VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    // memmove(TEXT_RAM + COLUMNS * n, TEXT_RAM + COLUMNS * n, COLUMNS * (ROWS - n));

    // IO_VCTRL = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    // memmove(TEXT_RAM, TEXT_RAM + COLUMNS * n, COLUMNS * (ROWS - n));
}

static void scroll_up(int n) {
    if (n < 1)
        return;
    if (n > ROWS)
        n = ROWS;

    IO_VCTRL = VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    memmove(TEXT_RAM, TEXT_RAM + COLUMNS * n, COLUMNS * (ROWS - n));
    memset(TEXT_RAM + COLUMNS * (ROWS - n), ' ', COLUMNS * n);

    IO_VCTRL = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    memmove(TEXT_RAM, TEXT_RAM + COLUMNS * n, COLUMNS * (ROWS - n));
    memset(TEXT_RAM + COLUMNS * (ROWS - n), text_color, COLUMNS * n);
}

static void scroll_down(int n) {
    if (n < 1)
        return;
    if (n > ROWS)
        n = ROWS;

    IO_VCTRL = VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    memmove(TEXT_RAM + COLUMNS * n, TEXT_RAM, COLUMNS * (ROWS - n));
    memset(TEXT_RAM, ' ', COLUMNS * n);

    IO_VCTRL = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
    memmove(TEXT_RAM + COLUMNS * n, TEXT_RAM, COLUMNS * (ROWS - n));
    memset(TEXT_RAM, text_color, COLUMNS * n);
}

static void recalc_p(void) {
    text_p = TEXT_RAM + text_y * COLUMNS + text_x;
}

static void drawchar(uint8_t ch) {
    if (ch >= ' ') {
        IO_VCTRL    = VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
        *text_p     = (ch);
        IO_VCTRL    = VCTRL_TEXTPAGE2 | VCTRL_80COLUMNS | VCTRL_REMAP_BORDER_CH | VCTRL_TEXT_EN;
        *(text_p++) = text_color;

        text_x++;
    }
}

static void drawstr(const char *s) {
    while (*s) {
        drawchar(*(s++));
        s++;
    }
}

int get_param(int defval) {
    if (cmd_params[0] < '0' || cmd_params[0] > '9')
        return defval;

    int n = 0;
    while (cmd_params[0] >= '0' && cmd_params[0] <= '9') {
        n = n * 10 + (cmd_params[0] - '0');
        cmd_params++;
    }
    return n;
}

static void handle_sgr(void) {
    // printf("\r\nSGR:'%s'\r\n", params);

    while (1) {
        int n = get_param(0);
        // printf("- %d\r\n", n);

        if (n == 0) {
            // Reset
            attributes = 0;
            fg_col     = 7;
            bg_col     = 0;
        } else if (n == 1) {
            // Bold
            attributes |= 1;
        } else if (n == 4) {
            // Underline
        } else if (n == 7) {
            // Reverse video
            attributes |= 2;
        } else if (n == 10) {
            // Primary (default) font
            attributes = 0;
        } else if (n >= 30 && n <= 37) {
            // Foreground color
            fg_col = n - 30;
        } else if (n == 39) {
            // Default foreground color
            fg_col = 7;
        } else if (n >= 40 && n <= 47) {
            // Background color
            bg_col = n - 40;
        } else if (n == 49) {
            // Default background color
            fg_col = 0;
        } else if (n >= 90 && n <= 97) {
            // Bright foreground color
            fg_col = n - 90 + 8;
        } else if (n >= 100 && n <= 107) {
            // Bright background color
            bg_col = n - 100 + 8;
        } else {
            text_color = 0xF0;
            printf("\r\nSGR:'%d'\r\n", n);
        }

        if (cmd_params[0] != ';')
            break;

        cmd_params++;
    }

    if (attributes & 2) {
        text_color = (bg_col << 4) | fg_col;
        if (attributes & 1) {
            text_color |= 0x80;
        }
    } else {
        text_color = (fg_col << 4) | bg_col;
        if (attributes & 1) {
            text_color |= 0x80;
        }
    }
}

static void cursor_set(int x, int y) {
    if (x < 0)
        x = 0;
    else if (x > COLUMNS - 1)
        x = COLUMNS - 1;
    else if (y < 0)
        y = 0;
    else if (y > ROWS - 1)
        y = ROWS - 1;
    text_x = x;
    text_y = y;
    recalc_p();
}

static void handle_csi(void) {
    cmd_params          = escape_cmd + 2;
    int  len            = strlen(escape_cmd);
    char cmd            = escape_cmd[len - 1];
    escape_cmd[len - 1] = 0;

    switch (cmd) {
        case 'A': cursor_set(text_x, text_y - get_param(1)); break;
        case 'B': cursor_set(text_x, text_y + get_param(1)); break;
        case 'C': cursor_set(text_x + get_param(1), text_y); break;
        case 'D': cursor_set(text_x - get_param(1), text_y); break;
        case 'E': cursor_set(0, text_y + get_param(1)); break;
        case 'F': cursor_set(0, text_y - get_param(1)); break;
        case 'G': cursor_set(get_param(1) - 1, text_y); break;
        case 'f': // Same as 'H', but not quite?
        case 'H': {
            int n = get_param(1);
            if (cmd_params[0] == ';')
                cmd_params++;
            int m = get_param(1);
            cursor_set(m - 1, n - 1);
            break;
        }
        case 'J': clear_display(get_param(0)); break;
        case 'K': clear_line(get_param(0)); break;
        case 'I': insert_line(get_param(0)); break;
        case 'S': scroll_up(get_param(1)); break;
        case 'T': scroll_down(get_param(1)); break;
        case 'm': handle_sgr(); return;

        case 'h':
        case 'l':
            // Bracketed paste mode
            break;

        default: {
            // text_color = 0xF5;
            printf("\r\nCSI:'%c' - '%s'\r\n", cmd, cmd_params);
            break;
        }
    }

    // printf("\r\nCSI(%c):'%s'\r\n", cmd, params);
}

void terminal_putchar(uint8_t ch) {
    if (escape_idx) {
        if (escape_idx < sizeof(escape_cmd) - 1)
            escape_cmd[escape_idx++] = ch;

        if (escape_cmd[1] == '[') {
            // CSI: Control Sequence Introducer
            if (escape_idx > 2 && ch >= 0x40 && ch <= 0x7E) {
                escape_cmd[escape_idx] = 0;
                escape_idx             = 0;
                handle_csi();
            }
        } else {
            escape_idx = 0;
        }
        return;
    }

    if (ch == 7) {
        // Bell

    } else if (ch == 8) {
        // Backspace
        if (text_x > 0) {
            text_x--;
        } else if (text_y > 0) {
            text_y--;
            text_x = COLUMNS - 1;
        }

    } else if (ch == 9) {
        // Tab
        do {
            text_x++;
        } while ((text_x & 7) != 0);
        recalc_p();

    } else if (ch == 10) {
        // Line feed
        text_y++;
        recalc_p();

    } else if (ch == 13) {
        // Carriage return
        text_x = 0;
        recalc_p();

    } else if (ch == 0x1B) {
        // Escape
        escape_cmd[escape_idx++] = ch;

    } else if (ch >= ' ') {
        drawchar(ch);
    } else if (ch > 0) {
        printf("\r\nUnknown char %d\r\n", ch);
    }

    if (text_x >= COLUMNS) {
        text_x = 0;
        text_y++;
        recalc_p();
    }
    if (text_y > ROWS - 1) {
        text_y = ROWS - 1;
        recalc_p();
        scroll_up(1);
    }
}
