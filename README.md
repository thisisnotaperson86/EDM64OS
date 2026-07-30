# NRMenu v1.0

[![Build NRMenu](https://github.com/NovenRetro/NRMenu/actions/workflows/build.yml/badge.svg)](https://github.com/NovenRetro/NRMenu/actions/workflows/build.yml)
[![Latest release](https://img.shields.io/github/v/release/NovenRetro/NRMenu)](https://github.com/NovenRetro/NRMenu/releases/latest)
[![ED64 Plus](https://img.shields.io/badge/hardware-ED64%20Plus-blue)](https://github.com/NovenRetro/NRMenu)

Frontend visual para **ED64 Plus**, basado en **ALTRA64**, con navegador de ROMs en dos paneles, carátulas, Favoritos e Historial.

> **NRMenu es gratuito y no se comercializa.** No contiene ni distribuye ROMs, BIOS, carátulas comerciales ni otro contenido protegido. Su finalidad es educativa y de preservación. Se entrega sin garantía y se recomienda respaldar siempre la tarjeta SD y las partidas.

## Estado del proyecto

**Firmware estable:** `NRMenu v1.0`  
**Revisión del repositorio y herramientas:** `1.0.1`  
**Hardware validado:** ED64 Plus con firmware v110  
**Base técnica fijada:** `ariahiro64/altra64@666dee10724dd725183cf2183d67e7632c73b2de`  
**Contenedor fijado:** `ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a`

NRMenu conserva las rutinas críticas de carga de ROM, emuladores y guardado de ALTRA64. La versión 1.0 fue validada en hardware real para navegación, carátulas, Favoritos, Historial, carpetas y arranque de juegos. Las limitaciones heredadas de ALTRA64 siguen siendo aplicables.

## Descargas e instalación rápida

La página de [Releases](https://github.com/NovenRetro/NRMenu/releases/latest) ofrece dos formas de instalación:

### Instalación completa en una SD nueva

Descargá el paquete:

```text
NRMenu-v1.0.x-ED64Plus-ReadyToUse.zip
```

1. Formateá la tarjeta SD en FAT32.
2. Extraé el contenido del ZIP en la raíz de la SD.
3. Agregá únicamente ROMs obtenidas legalmente en las carpetas correspondientes.
4. Expulsá la SD de forma segura.
5. Insertala en el ED64 Plus y encendé la consola.

### Actualización de una instalación existente de ALTRA64

Descargá el archivo `.v64` de la Release, copialo a:

```text
ED64P\OS64P.v64
```

y reemplazá el archivo anterior después de hacer un backup. La guía completa está en [docs/INSTALL_SD.md](docs/INSTALL_SD.md).

## Principales funciones

- Interfaz de dos paneles: lista a la izquierda y vista previa a la derecha.
- Carátula e información básica de la ROM seleccionada.
- Carga diferida de carátulas para mantener fluida la navegación.
- Pestañas **Browser**, **Favoritos** e **Historial** mediante `L/R`.
- Hasta 64 favoritos persistentes.
- Historial de los últimos 20 juegos.
- Fondos translúcidos en el navegador y ventanas secundarias opacas.
- Pantallas de información, controles y aviso de uso.
- Regreso correcto entre carpetas con `B`.
- Eliminación de archivos deshabilitada.
- Top 15 deshabilitado por inestabilidad y redundancia con Favoritos.

## Capturas reales

<table>
  <tr>
    <td align="center" width="50%">
      <img src="docs/images/nrmenu.png" alt="NRMenu mostrando el navegador principal" width="390"><br>
      <strong>Navegador principal</strong>
    </td>
    <td align="center" width="50%">
      <img src="docs/images/nrmenuroms.png" alt="NRMenu mostrando una ROM, su carátula e información" width="390"><br>
      <strong>Carátula e información de ROM</strong>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <img src="docs/images/nrmenufavs.png" alt="Pestaña Favoritos de NRMenu" width="390"><br>
      <strong>Favoritos persistentes</strong>
    </td>
    <td align="center" width="50%">
      <img src="docs/images/nrmenuhist.png" alt="Pestaña Historial de NRMenu" width="390"><br>
      <strong>Historial de juegos</strong>
    </td>
  </tr>
</table>

## Controles

| Control | Acción |
|---|---|
| `L / R` | Cambiar entre Browser, Favoritos e Historial |
| `A` | Abrir carpeta o ejecutar archivo |
| `B` | Volver / cancelar |
| `START` | Iniciar el último juego |
| `C-Abajo` | Agregar o quitar Favorito |
| `Z + L` | Menú Mempak |
| `C-Izquierda` | Información de ROM / ver MPK |
| `C-Derecha` | Configuración de ROM |
| `C-Arriba` | Nombre completo |
| `Z` | Información → Controles → Aviso de uso |

`Z + C-Abajo`, Top 15 y el borrado de archivos están deshabilitados.

## Compilar con Docker en Windows

### Requisitos

1. Windows 10 u 11 de 64 bits.
2. [Git for Windows](https://git-scm.com/download/win).
3. [Docker Desktop](https://www.docker.com/products/docker-desktop/), iniciado y configurado para contenedores Linux.
4. PowerShell 5.1 o PowerShell 7.
5. Aproximadamente 3 GB libres para Docker, fuentes y objetos de compilación.

### Compilar

```bat
scripts\build.cmd
```

El script:

1. Descarga el commit exacto de ALTRA64 definido en `build.env`.
2. Copia los tres archivos finales de NRMenu desde `overrides/src`.
3. Compila con la imagen Docker fijada por digest.
4. Verifica tamaño, encabezado, título interno y marcadores.
5. Copia el resultado a:

```text
dist\OS64P_NRMENU_v1.0.1.v64
```

6. Genera el SHA-256 y un archivo `BUILD_INFO.txt` con la procedencia exacta.

Guía completa: [docs/BUILD_WINDOWS_DOCKER.md](docs/BUILD_WINDOWS_DOCKER.md)

## Instalar en la SD desde el repositorio

Con la tarjeta asignada como `D:`:

```bat
scripts\install-sd.cmd
```

El instalador solo reemplaza:

```text
D:\ED64P\OS64P.v64
```

Antes crea un backup local. No modifica ROMs, partidas, `ALTRA64.INI`, carátulas, Favoritos, Historial ni wallpaper.

Guía completa: [docs/INSTALL_SD.md](docs/INSTALL_SD.md)

## Carátulas

Vista previa del menú:

```text
92 × 65 px
D:\ED64P\BOXART\menu\XX.png
```

Pantalla grande de información:

```text
158 × 112 px
D:\ED64P\BOXART\lowres\XX.png
```

Para ROMs de Nintendo 64, `XX` son los dos caracteres centrales del Game ID. Ejemplo: `NMQE` usa `MQ.png`.

Conversión por lotes:

```bat
scripts\resize-boxart.cmd C:\CARATULAS_ORIGINALES
```

Guía: [docs/BOXART.md](docs/BOXART.md)

## Verificar el repositorio

Antes de crear un commit o una Release:

```bat
scripts\verify-repository.cmd
```

Para regenerar el manifiesto SHA-256 después de cambios intencionales:

```bat
scripts\update-manifest.cmd
```

El manifiesto excluye su propio archivo y las carpetas locales de build, backups y exportación.

## Estructura del repositorio

```text
build.env           Versiones fijadas de ALTRA64, Docker y salida
overrides/src/      Archivos C finales que reemplazan a ALTRA64
scripts/            Build, instalación, restauración y validación
tools/              Conversor de carátulas y validadores
docs/               Documentación técnica y de usuario
examples/           Plantilla de estructura para la SD
.github/             Build automático y plantillas de issues
dist/                Binario local generado; no se versiona
work/                Clon local fijado de ALTRA64; no se versiona
```

## Documentación

- [Compilar con Docker en Windows](docs/BUILD_WINDOWS_DOCKER.md)
- [Compilar en Linux/macOS](docs/BUILD_LINUX_MACOS.md)
- [Instalación y recuperación](docs/INSTALL_SD.md)
- [Carátulas](docs/BOXART.md)
- [Arquitectura y puntos de extensión](docs/ARCHITECTURE.md)
- [Procedencia reproducible de la fuente](docs/SOURCE_PROVENANCE.md)
- [Limitaciones conocidas](docs/KNOWN_ISSUES.md)
- [Pruebas de guardado](docs/SAVE_TESTING.md)
- [Solución de problemas](docs/TROUBLESHOOTING.md)
- [Preparar una release](docs/RELEASE_CHECKLIST.md)
- [Publicar cambios en GitHub](docs/PUBLISH_GITHUB.md)
- [Créditos](CREDITS.md)
- [Contribuir](CONTRIBUTING.md)

## Créditos y proyecto base

NRMenu no existiría sin ALTRA64 y su larga cadena de forks y colaboradores. El proyecto reconoce especialmente a saturnu, parasyte, networkfusion, gameblabla, moparisthebest, ariahiro64/JonesAlmighty, Suprapote, Xalusc, nopjne, Skawo y a los demás contribuidores de ALTRA64/alt64, además de los proyectos y bibliotecas mencionados por el código original.

La atribución detallada está en [CREDITS.md](CREDITS.md).

## Licencia y situación jurídica

Los repositorios upstream describen ALTRA64 como código abierto, pero la rama usada para este proyecto no contiene un archivo de licencia en su raíz. Por esa razón, NRMenu **no intenta relicenciar** el código heredado. Se conservan los encabezados y atribuciones originales. Consultá [LICENSE.md](LICENSE.md) y [NOTICE.md](NOTICE.md).

## Aviso

NRMenu no está afiliado con Nintendo, Krikzz, los fabricantes de ED64 Plus ni los titulares de los juegos. No se garantiza compatibilidad con todos los cartuchos, revisiones, ROM hacks, tarjetas SD, emuladores o sistemas de guardado. NovenRetro no se responsabiliza por pérdidas de datos o daños derivados del uso.
