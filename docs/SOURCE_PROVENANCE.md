# Procedencia reproducible de la fuente

## Base directa

NRMenu v1.0 utiliza como base:

```text
Repositorio: https://github.com/ariahiro64/altra64
Commit: 666dee10724dd725183cf2183d67e7632c73b2de
```

La revisión completa queda registrada en `build.env`.

## Entorno de compilación

La imagen Docker validada está fijada mediante digest:

```text
ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a
```

Usar un digest evita que un tag cambiante produzca en el futuro un resultado diferente.

## Archivos reemplazados

NRMenu sustituye:

```text
src/main.c
src/menu_about.c
src/menu_controls.c
```

Los archivos se conservan en `overrides/src/`.

## Verificación

Cada build genera `dist/BUILD_INFO.txt` con versión, nombre del ROM, tamaño, encabezado, SHA-256, commit upstream e imagen Docker.

GitHub Actions usa la misma configuración que los scripts locales.

## Proyectos relacionados

El historial de releases de `Suprapote/Altra64` se utiliza como referencia para documentar compatibilidad y limitaciones conocidas.

## Cambio de base upstream

Actualizar el commit de ALTRA64 no debe tratarse como una modificación menor:

1. crear una rama específica;
2. actualizar `ALTRA64_COMMIT`;
3. revisar diferencias upstream;
4. reaplicar los overrides;
5. compilar desde limpio;
6. probar navegación y ejecución;
7. probar guardados en hardware;
8. documentar el nuevo commit y digest;
9. publicar una nueva Release.
