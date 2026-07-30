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
Repositorio:
https://github.com/ariahiro64/altra64.git

Commit:
666dee10724dd725183cf2183d67e7632c73b2de

Imagen Docker:
ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a
```

No se compila desde `master` flotante. Esto evita que un cambio futuro upstream modifique silenciosamente el resultado de NRMenu v1.0.

## Componentes

### `build.env`

Fuente única de verdad para:

- versión de la revisión del repositorio;
- etiqueta del firmware;
- nombre de salida;
- repositorio upstream;
- commit exacto de ALTRA64;
- digest exacto de la imagen Docker.

### `overrides/src/main.c`

Contiene:

- interfaz de dos paneles;
- carga diferida de carátulas;
- Browser, Favoritos e Historial;
- persistencia de Favoritos e Historial;
- navegación entre pestañas;
- corrección del regreso a la carpeta padre;
- desactivación de Top 15;
- desactivación del borrado;
- ventanas opacas y tercera pantalla Z.

### `overrides/src/menu_about.c`

Contiene la pantalla principal de información y créditos.

### `overrides/src/menu_controls.c`

Contiene la ayuda de controles adaptada a NRMenu.

### `scripts/bootstrap.ps1`

Prepara `work/altra64` de forma determinista:

1. inicializa o limpia el repositorio temporal;
2. descarga el commit exacto;
3. verifica el SHA;
4. restaura la fuente upstream;
5. aplica los tres overrides.

### `scripts/build.ps1` y `scripts/build.sh`

Compilan con la imagen Docker fijada por digest y verifican:

- tamaño exacto de 4 MiB;
- encabezado N64 `80 37 12 40`;
- título interno `ED64Plus OS`;
- marcadores de NRMenu;
- ruta `/ED64P/ALTRA64.INI`.

Además generan:

```text
dist/OS64P_NRMENU_v1.0.1.v64
dist/OS64P_NRMENU_v1.0.1.v64.sha256
dist/BUILD_INFO.txt
```

### `tools/manifest.py`

Genera y valida `MANIFEST_SHA256.txt`. El manifiesto no se incluye a sí mismo y excluye carpetas locales de build, backup y exportación.

### `tools/verify_repository.py`

Comprueba:

- configuración reproducible;
- correspondencia entre `VERSION` y `build.env`;
- hashes de los tres overrides estables;
- presencia y ubicación de las cuatro capturas;
- workflow actualizado;
- ausencia de ROMs, saves y datos privados;
- validez del manifiesto.

## Datos en la SD

NRMenu crea o utiliza:

```text
/ED64P/NRDATA/FAVORITES.TXT
/ED64P/NRDATA/HISTORY.TXT
/ED64P/BOXART/menu/XX.png
/ED64P/BOXART/lowres/XX.png
```

La instalación desde el repositorio reemplaza únicamente:

```text
/ED64P/OS64P.v64
```

## Zonas críticas heredadas

Las siguientes funciones se conservaron sin cambios respecto de la base funcional validada:

- `loadrom()`
- `loadgenericrom()`
- `bootRom()`
- `backupSaveData()`
- `saveTypeFromSd()`
- `saveTypeToSd()`
- `readRomConfig()`
- `readEmuConfig()`

Sus hashes están documentados en `docs/CRITICAL_FUNCTION_VALIDATION.txt`.

## Estrategia para futuras versiones

1. No mover la base upstream sin una razón documentada.
2. Probar cualquier cambio del commit o contenedor como una migración separada.
3. Mantener un tag por release.
4. Ejecutar verificación, build limpio y pruebas en hardware.
5. No mezclar cambios visuales con modificaciones de guardado.
