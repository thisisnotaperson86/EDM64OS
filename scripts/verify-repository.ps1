$ErrorActionPreference = 'Stop'
$Root = Split-Path $PSScriptRoot -Parent

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
    throw 'Python 3 no está instalado o no está en PATH.'
}

python (Join-Path $Root 'tools\verify_repository.py')
exit $LASTEXITCODE
