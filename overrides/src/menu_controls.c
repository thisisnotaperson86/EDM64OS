#include <libdragon.h>
#include "types.h"
#include "menu.h"
#include "main.h"

void menu_controls(display_context_t disp)
{
    printText("       - CONTROLES NRMENU -", 4, 4, disp);
    printText(" ", 4, -1, disp);
    printText("L / R: Cambiar pestana", 4, -1, disp);
    printText("A: Abrir / ejecutar", 4, -1, disp);
    printText("B: Volver / cancelar", 4, -1, disp);
    printText("START: Iniciar ultimo juego", 4, -1, disp);
    printText(" ", 4, -1, disp);
    printText("C-Abajo: Agregar/quitar favorito", 4, -1, disp);
    printText("Z + L: Menu Mempak", 4, -1, disp);
    printText(" ", 4, -1, disp);
    printText("C-Izq: Info ROM / ver MPK", 4, -1, disp);
    printText("C-Der: Configuracion ROM", 4, -1, disp);
    printText("C-Arriba: Nombre completo", 4, -1, disp);
    printText(" ", 4, -1, disp);
    printText("Z: Info / controles / aviso", 4, -1, disp);
    printText(" ", 4, -1, disp);
    printText("B: Volver al menu", 4, -1, disp);
}
