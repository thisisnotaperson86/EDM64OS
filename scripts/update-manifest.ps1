$ErrorActionPreference = 'Stop'
$Root = Split-Path $PSScriptRoot -Parent

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    throw 'Python 3 no está instalado o no está en PATH.'
}

python (Join-Path $Root 'tools\manifest.py') update
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Host 'MANIFEST_SHA256.txt actualizado.' -ForegroundColor Green
