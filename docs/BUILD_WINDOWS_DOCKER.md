# Compilar NRMenu v1.0 con Docker en Windows

## 1. Requisitos

### Git for Windows

Instalá Git y aceptá la opción para agregarlo al `PATH`.

Verificación:

```powershell
git --version
```

### Docker Desktop

Instalá Docker Desktop, usá contenedores Linux y esperá hasta que indique que el motor está iniciado.

Verificación:

```powershell
docker version
docker info
```

### PowerShell

Windows 10/11 incluye PowerShell 5.1. PowerShell 7 también funciona.

## 2. Descargar NRMenu

Clonando este repositorio:

```powershell
cd C:\NR64
git clone https://github.com/TU-USUARIO/NRMenu.git
cd NRMenu
```

También se puede descargar `Code > Download ZIP` y extraerlo.

## 3. Compilar automáticamente

Desde la raíz:

```powershell
.\scripts\build.ps1
```

O con doble clic:

```text
scripts\build.cmd
```

### Qué hace el script

1. Verifica Git y Docker.
2. Clona `https://github.com/ariahiro64/altra64.git` en `work/altra64` si aún no existe.
3. Verifica que el Makefile sea el de ED64 Plus (`HEADERTITLE="ED64Plus OS"` y `PROG_NAME=OS64P`).
4. Copia `overrides/src/main.c`, `menu_about.c` y `menu_controls.c` a la fuente upstream.
5. Ejecuta:

```sh
docker run --rm -v <ruta>:/build ghcr.io/ariahiro64/altra64:master make clean
docker run --rm -v <ruta>:/build ghcr.io/ariahiro64/altra64:master make
```

6. Verifica:
   - Tamaño: 4.194.304 bytes.
   - Encabezado: `80 37 12 40`.
   - Título interno: `ED64Plus OS`.
7. Copia el resultado a `dist/OS64P_NRMENU_v1.0.v64`.
8. Genera `dist/OS64P_NRMENU_v1.0.v64.sha256`.

## 4. Forzar una descarga limpia del upstream

```powershell
.\scripts\build.ps1 -Fresh
```

Esto elimina únicamente `work/altra64` y vuelve a clonar ALTRA64. No toca `overrides`, `docs` ni `dist`.

## 5. Compilación manual

```powershell
git clone https://github.com/ariahiro64/altra64.git work\altra64
Copy-Item overrides\src\main.c work\altra64\src\main.c -Force
Copy-Item overrides\src\menu_about.c work\altra64\src\menu_about.c -Force
Copy-Item overrides\src\menu_controls.c work\altra64\src\menu_controls.c -Force

docker run --rm -v "${PWD}\work\altra64:/build" ghcr.io/ariahiro64/altra64:master make clean
docker run --rm -v "${PWD}\work\altra64:/build" ghcr.io/ariahiro64/altra64:master make
```

Salida upstream:

```text
work\altra64\bin\OS64P.v64
```

## 6. Errores frecuentes

### Docker no está iniciado

```text
error during connect
```

Abrí Docker Desktop y esperá a que el motor termine de iniciar.

### La unidad compartida no está permitida

Docker Desktop debe poder montar la carpeta del proyecto. Mové el repositorio a una ruta local simple, por ejemplo:

```text
C:\NR64\NRMenu
```

### El binario no mide 4 MB

No lo instales. Ejecutá nuevamente con `-Fresh` y revisá `dist/BUILD_LOG.txt`.

### Aparece `´╗┐@echo off`

El `.cmd` fue guardado con BOM. Los `.cmd` incluidos aquí están en ASCII. Si se editan, guardarlos como ANSI/ASCII o UTF-8 sin BOM.
