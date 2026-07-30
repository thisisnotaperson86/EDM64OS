# Checklist para una release

## Repositorio

- [ ] `VERSION` coincide con `NRMENU_RELEASE_VERSION` en `build.env`.
- [ ] `CHANGELOG.md` actualizado.
- [ ] README y README_EN actualizados.
- [ ] Las cuatro capturas reales existen.
- [ ] `scripts/update-manifest.cmd` ejecutado.
- [ ] `scripts/verify-repository.cmd` finaliza en `REPOSITORY OK`.
- [ ] No hay ROMs, saves, historiales, credenciales ni arte protegido.

## Build reproducible

- [ ] Commit upstream completo fijado.
- [ ] Imagen Docker fijada por digest.
- [ ] Compila desde limpio con `scripts/build.ps1 -Fresh`.
- [ ] ROM de 4.194.304 bytes.
- [ ] Encabezado `80 37 12 40`.
- [ ] Título interno `ED64Plus OS`.
- [ ] SHA-256 generado.
- [ ] `BUILD_INFO.txt` generado.
- [ ] Workflow de GitHub en verde.
- [ ] Artifact de GitHub Actions descargado y revisado.

## Hardware

- [ ] Arranque en ED64 Plus.
- [ ] Browser funcional.
- [ ] `B` vuelve nivel por nivel.
- [ ] Favoritos e Historial.
- [ ] Carátulas y demora de carga.
- [ ] Tres pantallas Z.
- [ ] C-Izquierda, C-Derecha y C-Arriba.
- [ ] Ejecución de una ROM N64 conocida.
- [ ] Ejecución de al menos un emulador configurado.
- [ ] Reset vuelve al menú.

## Guardado

- [ ] Backup de `SDSAVE`.
- [ ] Prueba EEPROM o advertencia explícita.
- [ ] Prueba SRAM o advertencia explícita.
- [ ] Prueba FlashRAM o advertencia explícita.

## Publicación

- [ ] Tag semántico creado.
- [ ] Binario renombrado de forma consistente.
- [ ] SHA-256 adjunto.
- [ ] `BUILD_INFO.txt` adjunto.
- [ ] Ready to Use saneado.
- [ ] Notas de Release revisadas.
- [ ] Créditos y disclaimer visibles.
- [ ] No mover tags ya publicados.
