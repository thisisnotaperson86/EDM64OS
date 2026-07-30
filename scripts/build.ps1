param([switch]$Fresh)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'common.ps1')
$Config = Get-NRMenuBuildConfig -Root $Root

$Work = Join-Path $Root 'work\altra64'
$Dist = Join-Path $Root 'dist'
$Log = Join-Path $Dist 'BUILD_LOG.txt'
$Output = Join-Path $Dist $Config.NRMENU_OUTPUT_NAME
$HashFile = "$Output.sha256"
$InfoFile = Join-Path $Dist 'BUILD_INFO.txt'
$DockerImage = $Config.ALTRA64_DOCKER_IMAGE

New-Item -ItemType Directory -Force $Dist | Out-Null
"NRMenu repository v$($Config.NRMENU_RELEASE_VERSION) build - $(Get-Date -Format o)" | Set-Content $Log

try {
    if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
        throw 'Docker no está instalado o no está en PATH.'
    }

    docker info 2>&1 | Tee-Object -FilePath $Log -Append | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw 'Docker Desktop no está iniciado.'
    }

    & (Join-Path $PSScriptRoot 'bootstrap.ps1') -Fresh:$Fresh

    Write-Host "`nDescargando/verificando la imagen Docker fijada..." -ForegroundColor Cyan
    docker pull $DockerImage 2>&1 | Tee-Object -FilePath $Log -Append
    if ($LASTEXITCODE -ne 0) {
        throw "No se pudo obtener la imagen Docker fijada: $DockerImage"
    }

    $MountPath = ($Work -replace '\\', '/')
    $Mount = "${MountPath}:/build"

    docker run --rm -v $Mount $DockerImage make clean 2>&1 |
        Tee-Object -FilePath $Log -Append
    if ($LASTEXITCODE -ne 0) {
        throw 'make clean falló.'
    }

    docker run --rm -v $Mount $DockerImage make 2>&1 |
        Tee-Object -FilePath $Log -Append
    if ($LASTEXITCODE -ne 0) {
        throw 'La compilación falló.'
    }

    $Built = Join-Path $Work 'bin\OS64P.v64'
    if (-not (Test-Path $Built)) {
        throw 'No se generó bin\OS64P.v64.'
    }

    $Bytes = [IO.File]::ReadAllBytes($Built)
    if ($Bytes.Length -ne 4194304) {
        throw "Tamaño incorrecto: $($Bytes.Length)"
    }

    $Header = (($Bytes[0..3] | ForEach-Object { $_.ToString('X2') }) -join ' ')
    if ($Header -ne '80 37 12 40') {
        throw "Encabezado incorrecto: $Header"
    }

    $Title = [Text.Encoding]::ASCII.GetString($Bytes[32..51]).Trim()
    if ($Title -ne 'ED64Plus OS') {
        throw "Título interno incorrecto: $Title"
    }

    $Ascii = [Text.Encoding]::ASCII.GetString($Bytes)
    foreach ($Marker in @(
        'NRMenu v1.0',
        'www.novenretro.com',
        'AVISO DE USO',
        '/ED64P/ALTRA64.INI'
    )) {
        if (-not $Ascii.Contains($Marker)) {
            throw "Falta marcador en ROM: $Marker"
        }
    }

    Copy-Item $Built $Output -Force
    $Hash = (Get-FileHash $Output -Algorithm SHA256).Hash
    "$Hash  $($Config.NRMENU_OUTPUT_NAME)" | Set-Content $HashFile -Encoding ASCII

    @"
NRMenu repository release: $($Config.NRMENU_RELEASE_VERSION)
Firmware label: NRMenu v$($Config.NRMENU_FIRMWARE_LABEL)
Output: $($Config.NRMENU_OUTPUT_NAME)
Size: $($Bytes.Length)
Header: $Header
Internal title: $Title
SHA256: $Hash
ALTRA64 repository: $($Config.ALTRA64_REPOSITORY)
ALTRA64 commit: $($Config.ALTRA64_COMMIT)
Docker image: $DockerImage
Build date: $(Get-Date -Format o)
"@ | Set-Content $InfoFile -Encoding UTF8

    Write-Host "`nBUILD OK" -ForegroundColor Green
    Write-Host "ROM: $Output"
    Write-Host "SHA256: $Hash"
    Write-Host "ALTRA64 commit: $($Config.ALTRA64_COMMIT)"
    Write-Host "Docker image: $DockerImage"
}
catch {
    $_ | Out-String | Add-Content $Log
    Write-Host "`nERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Log: $Log"
    exit 1
}
