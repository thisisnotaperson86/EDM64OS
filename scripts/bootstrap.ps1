param([switch]$Fresh)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'common.ps1')
$Config = Get-NRMenuBuildConfig -Root $Root

$Work = Join-Path $Root 'work\altra64'
$Parent = Split-Path $Work -Parent
$Repository = $Config.ALTRA64_REPOSITORY
$Commit = $Config.ALTRA64_COMMIT

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git no está instalado o no está en PATH.'
}

if ($Fresh -and (Test-Path $Work)) {
    Remove-Item $Work -Recurse -Force
}

New-Item -ItemType Directory -Force $Parent | Out-Null

if (-not (Test-Path (Join-Path $Work '.git'))) {
    if (Test-Path $Work) {
        Remove-Item $Work -Recurse -Force
    }

    New-Item -ItemType Directory -Force $Work | Out-Null
    git -C $Work init | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw 'No se pudo inicializar el repositorio temporal de ALTRA64.'
    }

    git -C $Work remote add origin $Repository
    if ($LASTEXITCODE -ne 0) {
        throw 'No se pudo configurar el remoto de ALTRA64.'
    }
}
else {
    $Origin = (git -C $Work remote get-url origin).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw 'No se pudo leer el remoto del repositorio temporal.'
    }

    if ($Origin -ne $Repository) {
        git -C $Work remote set-url origin $Repository
        if ($LASTEXITCODE -ne 0) {
            throw 'No se pudo corregir el remoto del repositorio temporal.'
        }
    }
}

git -C $Work fetch --depth 1 origin $Commit
if ($LASTEXITCODE -ne 0) {
    throw "No se pudo descargar el commit fijado de ALTRA64: $Commit"
}

git -C $Work checkout --detach --force FETCH_HEAD
if ($LASTEXITCODE -ne 0) {
    throw "No se pudo seleccionar el commit fijado: $Commit"
}

git -C $Work reset --hard $Commit | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw 'No se pudo restaurar la fuente upstream.'
}

git -C $Work clean -fdx | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw 'No se pudo limpiar la fuente upstream.'
}

$Head = (git -C $Work rev-parse HEAD).Trim()
if ($Head -ne $Commit) {
    throw "Commit upstream inesperado. Esperado: $Commit. Detectado: $Head"
}

$Makefile = Join-Path $Work 'Makefile'
$Make = Get-Content $Makefile -Raw
if ($Make -notmatch 'HEADERTITLE\s*=\s*"ED64Plus OS"' -or $Make -notmatch 'PROG_NAME\s*=\s*OS64P') {
    throw 'El commit descargado no coincide con la base ED64 Plus esperada.'
}

foreach ($Name in @('main.c', 'menu_about.c', 'menu_controls.c')) {
    $From = Join-Path $Root "overrides\src\$Name"
    $To = Join-Path $Work "src\$Name"

    if (-not (Test-Path $From)) {
        throw "Falta el override: $From"
    }

    Copy-Item $From $To -Force
}

Write-Host "Fuente reproducible preparada en $Work" -ForegroundColor Green
Write-Host "ALTRA64 commit: $Commit"
Write-Host "Docker image: $($Config.ALTRA64_DOCKER_IMAGE)"
