# Compilar NRMenu con Docker en Windows

## Requisitos

- Git for Windows disponible en `PATH`.
- Docker Desktop iniciado con contenedores Linux.
- PowerShell 5.1 o PowerShell 7.
- Python 3 disponible en `PATH`.

Comprobación rápida:

```powershell
git --version
docker info
python --version
```

## Descargar NRMenu

```powershell
cd C:\NR64
git clone https://github.com/NovenRetro/NRMenu.git
cd NRMenu
```

También puede descargarse desde `Code > Download ZIP`; para contribuir se recomienda Git.

## Verificar antes de compilar

```powershell
.\scripts\verify-repository.ps1
```

La verificación revisa configuración, estructura, enlaces locales, capturas y archivos privados. No exige hashes fijos de los fuentes C.

## Compilar automáticamente

```powershell
.\scripts\build.ps1
```

O con doble clic en `scripts\build.cmd`.

El script:

1. lee `build.env`;
2. descarga el commit exacto de ALTRA64;
3. verifica que corresponda a la base ED64 Plus;
4. aplica los tres overrides;
5. usa la imagen Docker fijada por digest;
6. ejecuta `make clean` y `make`;
7. verifica tamaño, encabezado, título interno y marcadores;
8. genera:

```text
dist\OS64P_NRMENU_v1.0.1.v64
dist\OS64P_NRMENU_v1.0.1.v64.sha256
dist\BUILD_INFO.txt
```

## Build limpio

```powershell
.\scripts\build.ps1 -Fresh
```

Esto vuelve a preparar únicamente `work/altra64`. No modifica los overrides, la documentación, la SD ni los archivos previos de `dist` hasta completar el nuevo build.

## Compilación manual reproducible

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

## Errores frecuentes

### Docker no está iniciado

Abrí Docker Desktop y esperá hasta que el motor termine de iniciar.

### No se puede descargar el commit o la imagen

Revisá conexión, proxy, firewall y acceso a GitHub/GitHub Container Registry. No reemplaces el digest por `:master` sin documentar y validar el cambio.

### El binario no mide 4 MB

No lo instales. Repetí el build con `-Fresh` y revisá `dist\BUILD_LOG.txt`.

### Aparece `´╗┐@echo off`

El `.cmd` fue guardado con BOM. Los `.cmd` del repositorio deben mantenerse en ASCII o UTF-8 sin BOM.
