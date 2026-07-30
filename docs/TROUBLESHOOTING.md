# Solución de problemas

## El ED64 Plus no inicia después de instalar

1. Restaurar el `OS64P.v64` anterior.
2. Verificar que el nuevo archivo mida exactamente 4.194.304 bytes.
3. Verificar encabezado `80 37 12 40`.
4. Confirmar que se llame exactamente `OS64P.v64`.
5. Recompilar con `scripts\build.cmd -Fresh`.

## `Please insert SD card` o pantalla negra

Revisar formato FAT32, contactos y slot, estructura `ED64P`, archivo anterior y compatibilidad de la SD.

## `B` no vuelve a la carpeta anterior

NRMenu v1.0 incluye una corrección específica de la ruta padre. Confirmá que la pantalla de información indique `NRMenu v1.0`.

## La navegación se vuelve lenta

- Desactivar temporalmente `sound_on` y `bgm_on` en `ALTRA64.INI`.
- Verificar velocidad de la SD.
- Usar imágenes de menú de 92 × 65.
- La carátula debe cargar después de una pausa cercana a un segundo.

## No aparece una carátula

- Confirmar el Game ID mostrado.
- Usar los dos caracteres centrales en mayúsculas.
- Ruta: `ED64P/BOXART/menu/XX.png`.
- PNG de 92 × 65.
- Añadir `00.png` como fallback.

## Favoritos o Historial vacíos

Revisar:

```text
ED64P/NRDATA/FAVORITES.TXT
ED64P/NRDATA/HISTORY.TXT
```

La SD debe permitir escritura y las rutas registradas deben seguir existiendo.

## La instalación dice OK pero no arranca

Una copia exitosa solo confirma que el archivo llegó a la SD. Los scripts verifican tamaño, encabezado, título y SHA-256; aun así, conservá siempre un backup probado.

## El build cambia sin modificar NRMenu

Confirmá que `build.env` conserve el commit y digest fijados y que los scripts no hayan vuelto a usar `master`.

```bat
scripts\verify-repository.cmd
scripts\build.cmd -Fresh
```

Revisá `dist\BUILD_INFO.txt`.

## El verificador falla

Leé cada error. El verificador no exige hashes fijos del código; normalmente informa claves faltantes, enlaces locales rotos, imágenes ausentes, scripts `.cmd` con BOM o datos privados dentro del repositorio.
