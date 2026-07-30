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
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'common.ps1')
$Config = Get-NRMenuBuildConfig -Root $Root

$Source = Join-Path $Root "dist\$($Config.NRMENU_OUTPUT_NAME)"
$Drive = "$DriveLetter`:"
$Ed64 = Join-Path $Drive 'ED64P'
$Dest = Join-Path $Ed64 'OS64P.v64'
$BackupRoot = Join-Path $Root 'backups'
$Stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$Backup = Join-Path $BackupRoot "before_NRMenu_v$($Config.NRMENU_RELEASE_VERSION)_$Stamp"
$Last = Join-Path $BackupRoot 'LAST_BACKUP.txt'

try {
    foreach ($Path in @($Source, $Ed64, $Dest)) {
        if (-not (Test-Path $Path)) {
            throw "No se encontró: $Path"
        }
    }

    $Bytes = [IO.File]::ReadAllBytes($Source)
    if ($Bytes.Length -ne 4194304) {
        throw 'El ROM no mide 4 MB.'
    }

    $Header = (($Bytes[0..3] | ForEach-Object { $_.ToString('X2') }) -join ' ')
    if ($Header -ne '80 37 12 40') {
        throw "Encabezado incorrecto: $Header"
    }

    $Title = [Text.Encoding]::ASCII.GetString($Bytes[32..51]).Trim()
    if ($Title -ne 'ED64Plus OS') {
        throw "Título interno incorrecto: $Title"
    }

    New-Item -ItemType Directory -Force $Backup | Out-Null
    Copy-Item $Dest (Join-Path $Backup 'OS64P.v64') -Force
    $Backup | Set-Content $Last
    Copy-Item $Source $Dest -Force

    $SourceHash = (Get-FileHash $Source -Algorithm SHA256).Hash
    $DestHash = (Get-FileHash $Dest -Algorithm SHA256).Hash
    if ($SourceHash -ne $DestHash) {
        throw 'El hash copiado no coincide.'
    }

    Write-Host "INSTALACION OK EN $Drive" -ForegroundColor Green
    Write-Host "Backup: $Backup"
    Write-Host "SHA256: $DestHash"
    Write-Host 'Solo se reemplazó ED64P\OS64P.v64.'
}
catch {
    Write-Host "ERROR REAL DE INSTALACION: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
