# NRMenu v1.0.1

Revisión de mantenimiento, documentación y reproducibilidad del proyecto. El firmware continúa siendo **NRMenu v1.0**, validado en ED64 Plus; los tres archivos C funcionales no fueron modificados.

## Mejoras

- Build reproducible con commit exacto de ALTRA64.
- Imagen Docker fijada por digest SHA-256.
- GitHub Actions actualizado.
- Manifiesto SHA-256 regenerable y verificable.
- Verificador automático del repositorio.
- `BUILD_INFO.txt` con procedencia completa.
- README ampliado con instalación completa, actualización y cuatro capturas reales.
- Documentación de compilación y publicación revisada.

## Base reproducible

```text
ALTRA64 commit:
666dee10724dd725183cf2183d67e7632c73b2de

Docker image:
ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a
```

## Instalación completa

Descargá:

```text
NRMenu-v1.0.1-ED64Plus-ReadyToUse.zip
```

Extraé el contenido en la raíz de una SD FAT32 y agregá únicamente ROMs obtenidas legalmente.

## Actualización

Descargá:

```text
NRMenu-v1.0.1-OS64P.v64
```

Renombralo como:

```text
ED64P/OS64P.v64
```

después de respaldar el archivo anterior.

## Importante

- NRMenu es gratuito y no se comercializa.
- No incluye ni distribuye contenido protegido.
- Su finalidad es educativa y de preservación.
- Se basa en ALTRA64 y conserva sus créditos.
- No se garantiza compatibilidad absoluta.
- Realizá siempre backups de la SD y de las partidas.
