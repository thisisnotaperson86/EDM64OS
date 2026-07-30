# Opción de repositorio autocontenido

El paquete principal usa un modelo **overlay**: guarda solo los archivos modificados por NRMenu y clona ALTRA64 al compilar. Esto hace más clara la autoría y reduce duplicación.

Para crear una copia completa de la fuente:

```powershell
.\scripts\create-full-source.ps1 -Fresh
```

Salida:

```text
export\NRMenu-full-source
```

Esa carpeta contendrá la fuente completa de ALTRA64 con los overrides de NRMenu ya aplicados, sin el historial `.git`, objetos ni binarios.

## Publicarla como fork completo

1. Revisar `LICENSE.md` y la situación de licencia upstream.
2. Entrar a `export\NRMenu-full-source`.
3. Copiar allí la documentación de NRMenu que se quiera conservar.
4. Inicializar un repositorio nuevo o, preferentemente, crear un fork real de `ariahiro64/altra64` en GitHub para mantener visible la genealogía.
5. Añadir el repositorio original como `upstream`:

```sh
git remote add upstream https://github.com/ariahiro64/altra64.git
```

## Recomendación

Para la primera publicación de NovenRetro se recomienda mantener el repositorio overlay preparado en este ZIP. Un fork autocontenido es útil para archivado a largo plazo, pero duplica todo el código heredado y exige revisar con más cuidado créditos y licencia.


## Base recomendada para una exportación reproducible

La versión 1.0.1 fija la fuente upstream en:

```text
666dee10724dd725183cf2183d67e7632c73b2de
```

El script `create-full-source.ps1` utiliza automáticamente esa revisión y copia `build.env` dentro de la exportación como constancia de procedencia.
