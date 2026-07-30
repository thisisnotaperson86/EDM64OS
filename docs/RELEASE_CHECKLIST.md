# Checklist para una Release

## Repositorio

- [ ] `VERSION` coincide con `NRMENU_RELEASE_VERSION` en `build.env`.
- [ ] `CHANGELOG.md`, README y README_EN actualizados.
- [ ] Las cuatro capturas reales existen y cargan correctamente.
- [ ] `scripts/verify-repository.cmd` finaliza en `REPOSITORY OK`.
- [ ] No hay ROMs, saves, historiales, credenciales ni datos privados.
- [ ] Los enlaces locales de la documentación son válidos.

## Build reproducible

- [ ] Commit upstream completo fijado.
- [ ] Imagen Docker fijada por digest.
- [ ] Compila desde limpio con `scripts/build.ps1 -Fresh`.
- [ ] ROM de 4.194.304 bytes.
- [ ] Encabezado `80 37 12 40`.
- [ ] Título interno `ED64Plus OS`.
- [ ] SHA-256 y `BUILD_INFO.txt` generados.
- [ ] Workflow de GitHub en verde.
- [ ] Artifact de GitHub Actions descargado y revisado.

## Hardware

- [ ] Arranque en ED64 Plus.
- [ ] Browser funcional y `B` vuelve nivel por nivel.
- [ ] Favoritos e Historial.
- [ ] Carátulas y demora de carga.
- [ ] Tres pantallas Z.
- [ ] C-Izquierda, C-Derecha y C-Arriba.
- [ ] Ejecución de una ROM N64 conocida.
- [ ] Funciones adicionales incluidas en el paquete probadas.
- [ ] Reset vuelve al menú.

## Guardado

- [ ] Backup de `SDSAVE`.
- [ ] Prueba EEPROM o advertencia explícita.
- [ ] Prueba SRAM o advertencia explícita.
- [ ] Prueba FlashRAM o advertencia explícita.

## Publicación

- [ ] Tag semántico creado.
- [ ] Binario renombrado de forma consistente.
- [ ] SHA-256 y `BUILD_INFO.txt` adjuntos.
- [ ] Paquete Ready to Use revisado y sin ROMs ni datos personales.
- [ ] Notas de Release revisadas.
- [ ] Créditos y disclaimer visibles.
- [ ] No mover tags ya publicados.
