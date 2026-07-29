# Solución de problemas

## El ED64 Plus no inicia después de instalar

1. Restaurar el `OS64P.v64` anterior.
2. Verificar que el nuevo archivo mida exactamente 4.194.304 bytes.
3. Verificar encabezado `80 37 12 40`.
4. Confirmar que el archivo se llame exactamente `OS64P.v64`.
5. Recompilar con:

```powershell
.\scripts\build.ps1 -Fresh
```

## `Please insert SD card` o pantalla negra

No asumir que es NRMenu. Revisar:

- Formato FAT32.
- Contactos y slot de la SD.
- Estructura `ED64P`.
- Archivo funcional anterior.
- Compatibilidad de la tarjeta SD.

## B no vuelve a la carpeta anterior

La v1.0 incluye una corrección específica de la ruta padre. Confirmar que el binario provenga de estos overrides y que la pantalla de información diga `NRMenu v1.0`.

## La navegación se vuelve lenta

- Desactivar `sound_on` y `bgm_on` en `ALTRA64.INI` para diagnosticar.
- Verificar velocidad de la SD.
- No usar PNG enormes; las imágenes de menú deben ser 92 × 65.
- La carátula debe cargarse recién después de una pausa cercana a un segundo.

## No aparece una carátula

- Confirmar el Game ID mostrado.
- Usar los dos caracteres centrales en mayúsculas.
- Ruta correcta: `ED64P/BOXART/menu/XX.png`.
- PNG exacto de 92 × 65.
- Añadir `00.png` como fallback.

## Favoritos o Historial vacíos

Revisar:

```text
ED64P/NRDATA/FAVORITES.TXT
ED64P/NRDATA/HISTORY.TXT
```

La SD debe permitir escritura y las rutas deben seguir existiendo.

## La instalación dice OK pero no arranca

Una copia exitosa solo confirma que el archivo llegó a la SD, no que el ROM sea válido. Verificar siempre el binario antes de instalar. Los scripts actuales validan tamaño, encabezado, título y SHA-256.
