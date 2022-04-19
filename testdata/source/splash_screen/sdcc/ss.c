#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include "regs.h"
#include "file_io.h"

// #define PERFMON

static inline void wait_vsync(void) {
    // while (IO_VLINE < 216) {
    // }

    // Wait for line 216
    IO_VIRQLINE = 216;
    IO_IRQSTAT  = 2;
    while ((IO_IRQSTAT & 2) == 0) {
    }

    // while (IO_VSYNC & 1) {
    // }
    // while ((IO_VSYNC & 1) == 0) {
    // }
}

static uint8_t get_keyboard(void) {
    return IO_KEYBOARD;
}

static void exit_all(void) {
        IO_VCTRL = VCTRL_MODE_OFF | VCTRL_TEXT_EN;
        exit();
}

bool init(void) {
    // Map video RAM to $C000
    IO_BANK3 = 20;

    uint8_t palette[32];

    // Load in tile data
    int8_t fd = open("ss.bin", FO_RDONLY);
    if (fd < 0) {
        return false;
    }
    read(fd, (void *)0xC000, 0x4000);
    read(fd, palette, 32);
    close(fd);

    // Set palette
    for (uint8_t i = 0; i < 32; i++) {
        IO_VPALSEL  = i;
        IO_VPALDATA = palette[i];
    }
    return true;
}

int main(void) {
    puts("Tiledemo\n");
    if (!init()) {
        printf("error\n");
        return 1;
    }

    static uint8_t i;

    {
        uint8_t *tram = (uint8_t *)0x3000;
        uint8_t *cram = (uint8_t *)0x3400;

        // Clear screen
        for (int i = 0; i < 1000; i++) {
            tram[i] = ' ';
            cram[i] = 0x90;
        }

    }

    // Set video mode
    IO_VCTRL = VCTRL_MODE_TILE | VCTRL_SPR_EN | VCTRL_TEXT_EN | VCTRL_TEXT_PRIO;

#ifdef PERFMON
    IO_VPALSEL     = 0;
    uint8_t col0_l = IO_VPALDATA;
    IO_VPALSEL     = 1;
    uint8_t col0_h = IO_VPALDATA;
#endif

    static uint16_t scroll_x   = 0;
    static uint8_t  anim_frame = 0;
    static uint8_t  anim_delay = 0;

    while (1) {
        wait_vsync();

#ifdef PERFMON
        // Background: blue
        IO_VPALSEL  = 0;
        IO_VPALDATA = col0_l;
        IO_VPALSEL  = 1;
        IO_VPALDATA = col0_h;
#endif

        {
            uint8_t keyval = ~get_keyboard();
            if (keyval != 0)
                exit_all();
        }

#ifdef PERFMON
        // Background: black
        IO_VPALSEL  = 0;
        IO_VPALDATA = 0;
        IO_VPALSEL  = 1;
        IO_VPALDATA = 0;
#endif
    }

    // return 0;
}
