param([string]$DriveLetter = '')
$ErrorActionPreference = 'Stop'
$DriveLetter = $DriveLetter.Trim().TrimEnd(':')
if (-not $DriveLetter) {
    $DriveLetter = (Read-Host 'Letra de unidad de la SD (ejemplo E)').Trim().TrimEnd(':')
}
if ($DriveLetter -notmatch '^[A-Za-z]$') {
    throw "Letra de unidad inválida: $DriveLetter"
}
$DriveLetter = $DriveLetter.ToUpperInvariant()
$Root = Split-Path $PSScriptRoot -Parent
$BackupRoot = Join-Path $Root 'backups'
$Last = Join-Path $BackupRoot 'LAST_BACKUP.txt'
$Dest = "$DriveLetter`:\ED64P\OS64P.v64"
try {
    if (-not (Test-Path $Last)) { throw 'No existe backups\LAST_BACKUP.txt.' }
    $Dir=(Get-Content $Last -Raw).Trim()
    $Source=Join-Path $Dir 'OS64P.v64'
    if (-not (Test-Path $Source)) { throw "No se encontró $Source" }
    if (-not (Test-Path (Split-Path $Dest -Parent))) { throw "No se encontró la SD: $Dest" }
    Copy-Item $Source $Dest -Force
    $A=(Get-FileHash $Source -Algorithm SHA256).Hash
    $B=(Get-FileHash $Dest -Algorithm SHA256).Hash
    if ($A -ne $B) { throw 'El hash restaurado no coincide.' }
    Write-Host 'MENU ANTERIOR RESTAURADO OK' -ForegroundColor Green
    Write-Host "SHA256: $B"
}
catch {
    Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
