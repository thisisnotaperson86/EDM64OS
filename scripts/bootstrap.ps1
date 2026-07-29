param([switch]$Fresh)
$ErrorActionPreference = 'Stop'
$Root = Split-Path $PSScriptRoot -Parent
$Work = Join-Path $Root 'work\altra64'
$Upstream = 'https://github.com/ariahiro64/altra64.git'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git no está instalado o no está en PATH.'
}

if ($Fresh -and (Test-Path $Work)) {
    Remove-Item $Work -Recurse -Force
}

if (-not (Test-Path (Join-Path $Work '.git'))) {
    New-Item -ItemType Directory -Force (Split-Path $Work -Parent) | Out-Null
    git clone --depth 1 $Upstream $Work
    if ($LASTEXITCODE -ne 0) { throw 'No se pudo clonar ALTRA64.' }
}

$Makefile = Join-Path $Work 'Makefile'
$Make = Get-Content $Makefile -Raw
if ($Make -notmatch 'HEADERTITLE\s*=\s*"ED64Plus OS"' -or $Make -notmatch 'PROG_NAME\s*=\s*OS64P') {
    throw 'El upstream descargado no coincide con la rama ED64 Plus esperada.'
}

foreach ($Name in @('main.c','menu_about.c','menu_controls.c')) {
    $From = Join-Path $Root "overrides\src\$Name"
    $To = Join-Path $Work "src\$Name"
    if (-not (Test-Path $From)) { throw "Falta $From" }
    Copy-Item $From $To -Force
}

Write-Host "Fuente preparada en $Work" -ForegroundColor Green
