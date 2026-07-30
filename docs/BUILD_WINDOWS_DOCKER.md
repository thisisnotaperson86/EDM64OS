# Compilar NRMenu con Docker en Windows

## 1. Requisitos

### Git for Windows

Instalá Git y aceptá la opción para agregarlo al `PATH`.

```powershell
git --version
```

### Docker Desktop

Instalá Docker Desktop, utilizá contenedores Linux y esperá hasta que el motor esté iniciado.

```powershell
docker version
docker info
```

### PowerShell

Windows 10/11 incluye PowerShell 5.1. PowerShell 7 también funciona.

### Python 3

Python se utiliza para verificar el repositorio y administrar el manifiesto.

```powershell
python --version
```

## 2. Descargar NRMenu

```powershell
cd C:\NR64
git clone https://github.com/NovenRetro/NRMenu.git
cd NRMenu
```

También se puede descargar `Code > Download ZIP`, aunque para contribuir se recomienda Git.

## 3. Verificar antes de compilar

```powershell
.\scripts\verify-repository.ps1
```

La verificación confirma que los overrides estables no cambiaron, que las capturas existen y que el manifiesto coincide.

## 4. Compilar automáticamente

```powershell
.\scripts\build.ps1
```

O con doble clic:

```text
scripts\build.cmd
```

### Qué hace el script

1. Lee `build.env`.
2. Descarga el commit exacto de ALTRA64:

```text
666dee10724dd725183cf2183d67e7632c73b2de
```

3. Verifica que el Makefile corresponda a ED64 Plus.
4. Copia los tres overrides de NRMenu.
5. descarga la imagen Docker fijada por digest;
6. ejecuta `make clean` y `make`;
7. verifica:
   - tamaño de 4.194.304 bytes;
   - encabezado `80 37 12 40`;
   - título interno `ED64Plus OS`;
   - marcadores propios de NRMenu;
8. genera:

```text
dist\OS64P_NRMENU_v1.0.1.v64
dist\OS64P_NRMENU_v1.0.1.v64.sha256
dist\BUILD_INFO.txt
```

## 5. Forzar una preparación limpia

```powershell
.\scripts\build.ps1 -Fresh
```

Esto elimina únicamente `work/altra64`, vuelve a descargar el commit fijado y reaplica los overrides. No toca `overrides`, `docs`, la SD ni los archivos de `dist`.

## 6. Compilación manual reproducible

```powershell
$repo = "https://github.com/ariahiro64/altra64.git"
$commit = "666dee10724dd725183cf2183d67e7632c73b2de"
$image = "ghcr.io/ariahiro64/altra64@sha256:d2f82b3eabd75bae163fae707e701d1c85cd43c1c0a5ec880909495eb5abc14a"

New-Item -ItemType Directory -Force work\altra64 | Out-Null
git -C work\altra64 init
git -C work\altra64 remote add origin $repo
git -C work\altra64 fetch --depth 1 origin $commit
git -C work\altra64 checkout --detach FETCH_HEAD

Copy-Item overrides\src\main.c work\altra64\src\main.c -Force
Copy-Item overrides\src\menu_about.c work\altra64\src\menu_about.c -Force
Copy-Item overrides\src\menu_controls.c work\altra64\src\menu_controls.c -Force

docker pull $image
docker run --rm -v "${PWD}\work\altra64:/build" $image make clean
docker run --rm -v "${PWD}\work\altra64:/build" $image make
```

Salida upstream:

```text
work\altra64\bin\OS64P.v64
```

El método automático realiza verificaciones adicionales y es el recomendado.

## 7. Errores frecuentes

### Docker no está iniciado

```text
error during connect
```

Abrí Docker Desktop y esperá hasta que el motor termine de iniciar.

### No se puede descargar el commit

Verificá conexión a Internet, proxy, firewall y acceso a GitHub.

### No se puede descargar la imagen por digest

La imagen fijada debe permanecer disponible en GitHub Container Registry. No reemplaces el digest por `:master` sin documentar y validar el cambio.

### El binario no mide 4 MB

No lo instales. Ejecutá nuevamente con `-Fresh` y revisá:

```text
dist\BUILD_LOG.txt
```

### Aparece `´╗┐@echo off`

El `.cmd` fue guardado con BOM. Los `.cmd` del repositorio están en ASCII. Si se editan, deben guardarse como ASCII/ANSI o UTF-8 sin BOM.
