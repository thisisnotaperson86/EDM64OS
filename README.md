# NRMenu v1.0

Frontend visual para **ED64 Plus**, basado en **ALTRA64**, con navegador de ROMs en dos paneles, carátulas, Favoritos e Historial.

> **NRMenu es gratuito y no se comercializa.** No contiene ni distribuye ROMs, BIOS, emuladores, carátulas comerciales ni ningún otro contenido protegido. Su finalidad es educativa y de preservación. Se entrega sin garantía y se recomienda respaldar siempre la tarjeta SD y las partidas.

## Estado del proyecto

**Versión estable:** `1.0.0`  
**Hardware validado:** ED64 Plus con firmware v110  
**Base técnica:** `ariahiro64/altra64` para ED64 Plus  
**Compilación validada:** imagen Docker `ghcr.io/ariahiro64/altra64:master`

NRMenu conserva las rutinas críticas de carga de ROM, emuladores y guardado de ALTRA64. La versión 1.0 fue validada en hardware real para navegación, carátulas, Favoritos, Historial, carpetas y arranque de juegos. Las limitaciones heredadas de ALTRA64 siguen siendo aplicables.

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

## Inicio rápido para compilar en Windows

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

1. Clona `ariahiro64/altra64` dentro de `work/altra64`.
2. Copia los tres archivos finales de NRMenu desde `overrides/src`.
3. Ejecuta `make clean` y `make` dentro del contenedor oficial.
4. Verifica tamaño, encabezado y título interno.
5. Copia el resultado a:

```text
dist\OS64P_NRMENU_v1.0.v64
```

Guía completa: [docs/BUILD_WINDOWS_DOCKER.md](docs/BUILD_WINDOWS_DOCKER.md)

## Instalar en la SD

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

## Estructura del repositorio

```text
overrides/src/       Archivos C finales que reemplazan a ALTRA64
scripts/             Compilación, instalación y restauración para Windows
tools/               Conversor de carátulas
docs/                Documentación técnica y de usuario
examples/             Plantilla de estructura para la SD
.github/              Build automático e plantillas de issues
dist/                 Binario local generado; no se versiona
work/                 Clon local de ALTRA64; no se versiona
```

## Documentación

- [Compilar con Docker en Windows](docs/BUILD_WINDOWS_DOCKER.md)
- [Compilar en Linux/macOS](docs/BUILD_LINUX_MACOS.md)
- [Instalación y recuperación](docs/INSTALL_SD.md)
- [Carátulas](docs/BOXART.md)
- [Arquitectura y puntos de extensión](docs/ARCHITECTURE.md)
- [Opción de fork autocontenido](docs/FULL_FORK_OPTION.md)
- [Limitaciones conocidas](docs/KNOWN_ISSUES.md)
- [Pruebas de guardado](docs/SAVE_TESTING.md)
- [Solución de problemas](docs/TROUBLESHOOTING.md)
- [Preparar una release](docs/RELEASE_CHECKLIST.md)
- [Créditos](CREDITS.md)
- [Contribuir](CONTRIBUTING.md)

## Créditos y proyecto base

NRMenu no existiría sin ALTRA64 y su larga cadena de forks y colaboradores. El proyecto reconoce especialmente a saturnu, parasyte, networkfusion, gameblabla, moparisthebest, ariahiro64/JonesAlmighty, Suprapote, Xalusc, nopjne, Skawo y a los demás contribuidores de ALTRA64/alt64, además de los proyectos y bibliotecas mencionados por el código original.

La atribución detallada está en [CREDITS.md](CREDITS.md).

## Licencia y situación jurídica

Los repositorios upstream describen ALTRA64 como código abierto, pero la rama usada para este proyecto no contiene un archivo de licencia en su raíz. Por esa razón, NRMenu **no intenta relicenciar** el código heredado. Se conservan los encabezados y atribuciones originales. Revisá [LICENSE.md](LICENSE.md) y [NOTICE.md](NOTICE.md) antes de redistribuir binarios o derivados.

## Aviso

NRMenu no está afiliado con Nintendo, Krikzz, los fabricantes de ED64 Plus ni los titulares de los juegos. No se garantiza compatibilidad con todos los cartuchos, revisiones, ROM hacks, tarjetas SD, emuladores o sistemas de guardado. NovenRetro no se responsabiliza por pérdidas de datos o daños derivados del uso.

Sitio del proyecto: [www.novenretro.com](https://www.novenretro.com)
