# Contribuir a NRMenu

Gracias por colaborar.

## Antes de modificar

1. Leé `docs/ARCHITECTURE.md`, `docs/SOURCE_PROVENANCE.md` y `docs/KNOWN_ISSUES.md`.
2. Ejecutá `scripts/verify-repository.cmd`.
3. Compilá `main` sin cambios con `scripts/build.cmd -Fresh`.
4. Respaldá la SD y las partidas.
5. Probá primero en emulador cuando sea posible y luego en hardware real.

## Flujo recomendado

```sh
git checkout -b feature/nombre-corto
```

La fuente upstream reproducible se prepara en `work/altra64`. El commit upstream y la imagen Docker están fijados en `build.env`.

Cuando el cambio esté validado, copiá los archivos modificados a `overrides/src/` y ejecutá:

```bat
scripts\verify-repository.cmd
scripts\build.cmd -Fresh
```

## Pull requests

Cada PR debería indicar:

- qué problema resuelve;
- hardware y firmware utilizados;
- tarjeta SD y formato;
- juegos o funciones probadas;
- si modifica carga, CIC, guardado o emulación;
- resultado del verificador y del build limpio;
- capturas o video cuando el cambio sea visual.

## Zonas críticas

Los cambios en estas funciones requieren pruebas específicas:

- `loadrom()`
- `loadgenericrom()`
- `bootRom()`
- `backupSaveData()`
- `saveTypeFromSd()`
- `saveTypeToSd()`
- `readRomConfig()`
- `readEmuConfig()`

Los cambios de guardado deberían probar EEPROM 4K, EEPROM 16K, SRAM y FlashRAM.

## Contenido que no debe subirse

- ROMs.
- Partidas o historiales personales.
- Tokens, claves o credenciales.
- Copias completas de una SD personal.

Todo componente de terceros agregado al proyecto debe conservar sus créditos, licencias y condiciones de redistribución.
