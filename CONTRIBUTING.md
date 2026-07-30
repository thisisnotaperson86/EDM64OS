# Contribuir a NRMenu

Gracias por colaborar.

## Antes de modificar

1. Leé `docs/ARCHITECTURE.md`, `docs/SOURCE_PROVENANCE.md` y `docs/KNOWN_ISSUES.md`.
2. Ejecutá `scripts/verify-repository.cmd`.
3. Compilá `main` sin cambios con `scripts/build.cmd -Fresh` y confirmá que genera un ROM válido.
4. Respaldá la SD y todas las partidas.
5. Probá primero en emulador cuando sea posible y luego en hardware real.

## Flujo recomendado

```sh
git checkout -b feature/nombre-corto
```

La fuente upstream reproducible se genera en:

```text
work/altra64/src/
```

El commit upstream y la imagen Docker están fijados en:

```text
build.env
```

Cuando el cambio esté validado, copiá únicamente los archivos modificados a:

```text
overrides/src/
```

Después ejecutá:

```bat
scripts\update-manifest.cmd
scripts\verify-repository.cmd
scripts\build.cmd -Fresh
```

## Pull requests

Cada PR debería indicar:

- Qué problema resuelve.
- Hardware y firmware utilizados.
- Tarjeta SD y formato.
- Juegos o funciones probadas.
- Si modifica carga, CIC, guardado o emuladores.
- Resultado de `scripts/verify-repository.cmd`.
- Resultado de `scripts/build.cmd -Fresh`.
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
