param([ValidatePattern('^[A-Za-z]$')][string]$DriveLetter = 'D')
$ErrorActionPreference = 'Stop'
$Root = Split-Path $PSScriptRoot -Parent
$Source = Join-Path $Root 'dist\OS64P_NRMENU_v1.0.v64'
$Drive = "$DriveLetter`:"
$Ed64 = Join-Path $Drive 'ED64P'
$Dest = Join-Path $Ed64 'OS64P.v64'
$BackupRoot = Join-Path $Root 'backups'
$Stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$Backup = Join-Path $BackupRoot "before_NRMenu_v1_$Stamp"
$Last = Join-Path $BackupRoot 'LAST_BACKUP.txt'

try {
    foreach ($Path in @($Source,$Ed64,$Dest)) {
        if (-not (Test-Path $Path)) { throw "No se encontró: $Path" }
    }
    $Bytes = [IO.File]::ReadAllBytes($Source)
    if ($Bytes.Length -ne 4194304) { throw 'El ROM no mide 4 MB.' }
    $Header = (($Bytes[0..3] | ForEach-Object {$_.ToString('X2')}) -join ' ')
    if ($Header -ne '80 37 12 40') { throw "Encabezado incorrecto: $Header" }

    New-Item -ItemType Directory -Force $Backup | Out-Null
    Copy-Item $Dest (Join-Path $Backup 'OS64P.v64') -Force
    $Backup | Set-Content $Last
    Copy-Item $Source $Dest -Force

    $A=(Get-FileHash $Source -Algorithm SHA256).Hash
    $B=(Get-FileHash $Dest -Algorithm SHA256).Hash
    if ($A -ne $B) { throw 'El hash copiado no coincide.' }
    Write-Host "INSTALACION OK EN $Drive" -ForegroundColor Green
    Write-Host "Backup: $Backup"
    Write-Host "SHA256: $B"
    Write-Host 'Solo se reemplazó ED64P\OS64P.v64.'
}
catch {
    Write-Host "ERROR REAL DE INSTALACION: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
