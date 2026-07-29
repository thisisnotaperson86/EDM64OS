# Contribuir a NRMenu

Gracias por colaborar.

## Antes de modificar

1. Leé `docs/ARCHITECTURE.md` y `docs/KNOWN_ISSUES.md`.
2. Compilá `main` sin cambios y confirmá que genera un ROM válido.
3. Respaldá la SD y todas las partidas.
4. Probá primero en emulador cuando sea posible y luego en hardware real.

## Flujo recomendado

```sh
git checkout -b feature/nombre-corto
```

Trabajá sobre:

```text
work/altra64/src/
```

Cuando el cambio esté validado, copiá los archivos modificados a:

```text
overrides/src/
```

Después ejecutá:

```bat
scripts\build.cmd
```

## Pull requests

Cada PR debería indicar:

- Qué problema resuelve.
- Hardware y firmware utilizados.
- Tarjeta SD y formato.
- Juegos o funciones probadas.
- Si modifica carga, CIC, guardado o emuladores.
- Resultado de `scripts/build.cmd`.
- Capturas o video cuando el cambio sea visual.

## Zonas críticas

No modifiques sin pruebas específicas:

- `loadrom()`
- `loadgenericrom()`
- `bootRom()`
- `backupSaveData()`
- `saveTypeFromSd()`
- `saveTypeToSd()`
- `readRomConfig()`
- `readEmuConfig()`

Los cambios en guardado deben probar EEPROM 4K, EEPROM 16K, SRAM y FlashRAM.

## Contenido prohibido

No subas:

- ROMs o BIOS.
- Emuladores si su licencia no permite redistribución.
- Carátulas comerciales.
- Partidas personales.
- Tokens, claves o credenciales.
- Archivos completos de una SD personal.
