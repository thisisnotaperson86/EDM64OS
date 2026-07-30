# Procedencia reproducible de la fuente

## Base directa

NRMenu v1.0 utiliza como base:

```text
Repositorio:
https://github.com/ariahiro64/altra64

Commit exacto:
666dee10724dd725183cf2183d67e7632c73b2de

Fecha del commit upstream:
14 de noviembre de 2023

Mensaje:
i guess he wants colored lists
```

La revisión completa queda registrada en `build.env`.

## Entorno de compilación

La imagen Docker validada está fijada mediante digest:

```text
ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a
```

Usar un digest evita que el tag `master` apunte en el futuro a una imagen diferente.

## Archivos reemplazados

NRMenu sustituye únicamente:

```text
src/main.c
src/menu_about.c
src/menu_controls.c
```

Los archivos finales se conservan en:

```text
overrides/src/
```

## Verificación

Cada build genera `dist/BUILD_INFO.txt` con:

- versión del repositorio;
- etiqueta del firmware;
- nombre del ROM;
- tamaño y encabezado;
- SHA-256 del ROM;
- commit exacto de ALTRA64;
- imagen Docker exacta.

GitHub Actions aplica la misma configuración que los scripts locales.

## Proyectos relacionados

El repositorio `Suprapote/Altra64`, archivado en 2024, fue consultado para documentar releases estables y limitaciones conocidas. No se incluyen sus assets.

## Cambio de base upstream

Actualizar el commit de ALTRA64 no debe tratarse como una modificación menor. El proceso recomendado es:

1. crear una rama específica;
2. actualizar `ALTRA64_COMMIT`;
3. revisar diferencias upstream;
4. reaplicar los overrides;
5. compilar;
6. probar carpetas, Favoritos, Historial y ROMs;
7. probar guardados en hardware;
8. documentar el nuevo commit y digest;
9. publicar una nueva release.
