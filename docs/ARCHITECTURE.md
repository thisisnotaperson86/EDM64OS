# Arquitectura de NRMenu v1.0

## Resumen

NRMenu utiliza un modelo **overlay reproducible**:

```text
ALTRA64 fijado por commit
        +
overrides/src/main.c
overrides/src/menu_about.c
overrides/src/menu_controls.c
        =
NRMenu v1.0
```

Las versiones exactas están centralizadas en `build.env`.

## Base fijada

```text
Repositorio: https://github.com/ariahiro64/altra64.git
Commit: 666dee10724dd725183cf2183d67e7632c73b2de
Imagen Docker: ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a
```

No se compila desde un `master` flotante. Esto evita que un cambio upstream modifique silenciosamente el resultado.

## Componentes

### `build.env`

Fuente única de verdad para la versión del repositorio, etiqueta del firmware, nombre de salida, repositorio upstream, commit exacto e imagen Docker.

### `overrides/src/main.c`

Contiene la interfaz de dos paneles, carga diferida de carátulas, Browser/Favoritos/Historial, persistencia, navegación, corrección de ruta padre, desactivación de Top 15 y borrado, ventanas opacas y tercera pantalla Z.

### `overrides/src/menu_about.c`

Pantalla principal de información y créditos.

### `overrides/src/menu_controls.c`

Ayuda de controles adaptada a NRMenu.

### `scripts/bootstrap.ps1`

Prepara `work/altra64` de forma determinista, descarga el commit exacto, verifica la revisión y aplica los overrides.

### Scripts de build

`scripts/build.ps1` y `scripts/build.sh` compilan con la imagen fijada y verifican:

- tamaño exacto de 4 MiB;
- encabezado N64 `80 37 12 40`;
- título interno `ED64Plus OS`;
- marcadores de NRMenu;
- ruta `/ED64P/ALTRA64.INI`.

Generan el ROM, su SHA-256 y `BUILD_INFO.txt` dentro de `dist/`.

### `tools/verify_repository.py`

Realiza comprobaciones de mantenimiento que no bloquean cambios legítimos de código:

- configuración reproducible y versión;
- presencia de los overrides y archivos mínimos;
- enlaces locales de Markdown;
- capturas referenciadas;
- workflow de compilación;
- ausencia de datos privados y archivos de ROM evidentes;
- ausencia de BOM en scripts `.cmd`.

## Datos en la SD

NRMenu crea o utiliza:

```text
/ED64P/NRDATA/FAVORITES.TXT
/ED64P/NRDATA/HISTORY.TXT
/ED64P/BOXART/menu/XX.png
/ED64P/BOXART/lowres/XX.png
```

La instalación desde el repositorio reemplaza únicamente `/ED64P/OS64P.v64`.

## Zonas críticas heredadas

En NRMenu v1.0 se procuró conservar el comportamiento de estas funciones de ALTRA64:

- `loadrom()`
- `loadgenericrom()`
- `bootRom()`
- `backupSaveData()`
- `saveTypeFromSd()`
- `saveTypeToSd()`
- `readRomConfig()`
- `readEmuConfig()`

Pueden modificarse en contribuciones futuras, pero requieren build limpio y pruebas específicas en hardware.
