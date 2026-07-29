# Pruebas del sistema de guardado

NRMenu v1.0 no modifica intencionalmente las funciones críticas de guardado de la base funcional de ALTRA64. Aun así, todo cambio futuro debe probarse en hardware.

## Procedimiento general

1. Respaldar `ED64P/SDSAVE`.
2. Ejecutar un juego de prueba.
3. Crear una partida o cambio reconocible.
4. Guardar dentro del juego.
5. Esperar unos segundos.
6. Presionar Reset físico.
7. Esperar el regreso completo al menú.
8. Ejecutar el mismo juego y confirmar la partida.
9. Apagar, encender y confirmar nuevamente.

## Juegos sugeridos

| Memoria | Juego práctico | Prueba |
|---|---|---|
| EEPROM 4K | Super Mario 64 | Primera estrella y Save & Continue |
| EEPROM 16K | Mario Party 3 | Crear Story Mode y guardar progreso |
| SRAM 32K | Zelda: Ocarina of Time | Crear archivo y guardar manualmente |
| FlashRAM | Paper Mario | Crear perfil y volver mediante Reset |
| FlashRAM adicional | Pokémon Snap | Usar solo como prueba de limitación conocida |
| Controller Pak | Mario Kart 64 | Guardar un fantasma de Time Trial |

## Criterio de aprobación

```text
Crear → Guardar → Reset → Cargar → Modificar → Guardar → Reset → Apagar → Encender → Cargar
```

Documentar siempre:

- Región y revisión de la ROM.
- Hash de la ROM, sin compartirla.
- Tipo de save configurado.
- Firmware del ED64 Plus.
- Tamaño y fecha del archivo generado.
