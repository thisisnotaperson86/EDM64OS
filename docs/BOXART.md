# Carátulas en NRMenu

## Tamaños

### Vista previa del panel derecho

```text
92 × 65 px
/ED64P/BOXART/menu/
```

### Pantalla de información con C-Izquierda

```text
158 × 112 px
/ED64P/BOXART/lowres/
```

## Nombre de archivo para Nintendo 64

NRMenu lee el Game ID interno de cuatro caracteres y usa los dos caracteres centrales.

Ejemplo:

```text
Game ID: NMQE
Archivo: MQ.png
```

Otros ejemplos:

| Game ID | PNG |
|---|---|
| `NSME` | `SM.png` |
| `NZLE` | `ZL.png` |
| `NMVE` | `MV.png` |

## Limitación

Dos ROMs con el mismo ID corto comparten carátula. Esto es frecuente en romhacks que conservan el identificador del juego base.

Una mejora futura recomendable es buscar en este orden:

1. CRC o hash de ROM.
2. Game ID completo.
3. Nombre exacto de archivo.
4. ID corto actual.
5. `00.png`.

## Emuladores

Para archivos no N64, NRMenu intenta usar la extensión:

```text
NES.png
GB.png
GBC.png
SFC.png
SMC.png
```

Si no existe, usa `00.png`.

## Conversión por lotes

Instalar Python 3 y Pillow:

```powershell
py -m pip install -r tools\requirements.txt
```

Convertir a 92 × 65:

```powershell
py tools\resize_boxart.py C:\ENTRADA C:\SALIDA --size 92x65
```

Generar también las versiones 158 × 112:

```powershell
py tools\resize_boxart.py C:\ENTRADA C:\SALIDA_MENU --size 92x65
py tools\resize_boxart.py C:\ENTRADA C:\SALIDA_LOWRES --size 158x112
```

El wrapper `scripts/resize-boxart.cmd` crea ambas carpetas automáticamente.


