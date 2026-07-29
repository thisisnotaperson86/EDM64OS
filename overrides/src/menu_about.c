#include <libdragon.h>
#include <stdio.h>
#include "types.h"
#include "menu.h"
#include "main.h"
#include "everdrive.h"

void menu_about(display_context_t disp)
{
    char firmware_str[32];

    printText("NRMenu v1.0", 9, 8, disp);
    printText("Basado en ALTRA64", 9, -1, disp);

    sprintf(firmware_str, "ED64 Firmware v%03x", evd_getFirmVersion());
    printText(firmware_str, 9, -1, disp);

    printText(" ", 9, -1, disp);
    printText("ALTRA64: JonesAlmighty", 9, -1, disp);
    printText("github.com/ariahiro64", 9, -1, disp);
    printText("/altra64", 9, -1, disp);

    printText(" ", 9, -1, disp);
    printText("NRMenu por NovenRetro", 9, -1, disp);
    printText("www.novenretro.com", 9, -1, disp);

    printText(" ", 9, -1, disp);
    printText("Z: VER CONTROLES", 9, -1, disp);
}
