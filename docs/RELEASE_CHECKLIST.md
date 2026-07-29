# Checklist para una release

## Código

- [ ] Compila desde un clon limpio con `scripts/build.ps1 -Fresh`.
- [ ] ROM de 4.194.304 bytes.
- [ ] Encabezado `80 37 12 40`.
- [ ] Título interno `ED64Plus OS`.
- [ ] SHA-256 generado.
- [ ] Workflow de GitHub en verde.

## Hardware

- [ ] Arranque en ED64 Plus.
- [ ] Browser funcional.
- [ ] B vuelve nivel por nivel.
- [ ] Favoritos e Historial.
- [ ] Carátulas y demora de carga.
- [ ] Tres pantallas Z.
- [ ] C-Izquierda, C-Derecha y C-Arriba.
- [ ] Ejecución de una ROM N64 conocida.
- [ ] Ejecución de al menos un emulador configurado.
- [ ] Reset vuelve al menú.

## Datos

- [ ] Backup de SDSAVE.
- [ ] Prueba EEPROM.
- [ ] Prueba SRAM.
- [ ] Prueba FlashRAM o advertencia explícita.

## Publicación

- [ ] VERSION actualizado.
- [ ] CHANGELOG actualizado.
- [ ] README actualizado.
- [ ] KNOWN_ISSUES actualizado.
- [ ] Sin ROMs, saves o arte protegido.
- [ ] Tag semántico creado.
- [ ] Binario y SHA-256 adjuntos a la release.
