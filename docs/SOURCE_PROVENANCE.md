# Procedencia de la fuente

La base directa de NRMenu v1.0 es la rama `master` de:

```text
https://github.com/ariahiro64/altra64
```

La fuente upstream se compila con la imagen:

```text
ghcr.io/ariahiro64/altra64:master
```

NRMenu reemplaza únicamente:

```text
src/main.c
src/menu_about.c
src/menu_controls.c
```

El repositorio `Suprapote/Altra64`, archivado en 2024, fue consultado para documentar releases estables y limitaciones conocidas. No se incluyen sus assets.

La rama upstream figuraba actualizada por última vez el 14 de noviembre de 2023 al preparar esta documentación. Debido a que el repositorio NRMenu clona `master`, un cambio futuro upstream podría requerir adaptar los overrides. Para releases de largo plazo se recomienda crear un fork completo o fijar un commit una vez acordada la estrategia de licencia.
