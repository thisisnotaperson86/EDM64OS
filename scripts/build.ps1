param([switch]$Fresh)
$ErrorActionPreference = 'Stop'
$Root = Split-Path $PSScriptRoot -Parent
$Work = Join-Path $Root 'work\altra64'
$Dist = Join-Path $Root 'dist'
$Log = Join-Path $Dist 'BUILD_LOG.txt'
$Output = Join-Path $Dist 'OS64P_NRMENU_v1.0.v64'
$HashFile = "$Output.sha256"

New-Item -ItemType Directory -Force $Dist | Out-Null
"NRMenu v1.0 build - $(Get-Date -Format o)" | Set-Content $Log

try {
    if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
        throw 'Docker no está instalado o no está en PATH.'
    }
    docker info 2>&1 | Tee-Object -FilePath $Log -Append | Out-Null
    if ($LASTEXITCODE -ne 0) { throw 'Docker Desktop no está iniciado.' }

    & (Join-Path $PSScriptRoot 'bootstrap.ps1') -Fresh:$Fresh

    $Mount = ($Work -replace '\\','/') + ':/build'
    docker run --rm -v $Mount ghcr.io/ariahiro64/altra64:master make clean 2>&1 | Tee-Object -FilePath $Log -Append
    if ($LASTEXITCODE -ne 0) { throw 'make clean falló.' }

    docker run --rm -v $Mount ghcr.io/ariahiro64/altra64:master make 2>&1 | Tee-Object -FilePath $Log -Append
    if ($LASTEXITCODE -ne 0) { throw 'La compilación falló.' }

    $Built = Join-Path $Work 'bin\OS64P.v64'
    if (-not (Test-Path $Built)) { throw 'No se generó bin\OS64P.v64.' }

    $Bytes = [IO.File]::ReadAllBytes($Built)
    if ($Bytes.Length -ne 4194304) { throw "Tamaño incorrecto: $($Bytes.Length)" }
    $Header = (($Bytes[0..3] | ForEach-Object { $_.ToString('X2') }) -join ' ')
    if ($Header -ne '80 37 12 40') { throw "Encabezado incorrecto: $Header" }
    $Title = [Text.Encoding]::ASCII.GetString($Bytes[32..51]).Trim()
    if ($Title -ne 'ED64Plus OS') { throw "Título interno incorrecto: $Title" }
    $Ascii = [Text.Encoding]::ASCII.GetString($Bytes)
    foreach ($Marker in @('NRMenu v1.0','www.novenretro.com','AVISO DE USO','/ED64P/ALTRA64.INI')) {
        if (-not $Ascii.Contains($Marker)) { throw "Falta marcador en ROM: $Marker" }
    }

    Copy-Item $Built $Output -Force
    $Hash = (Get-FileHash $Output -Algorithm SHA256).Hash
    "$Hash  OS64P_NRMENU_v1.0.v64" | Set-Content $HashFile -Encoding ASCII
    Write-Host "`nBUILD OK" -ForegroundColor Green
    Write-Host "ROM: $Output"
    Write-Host "SHA256: $Hash"
}
catch {
    $_ | Out-String | Add-Content $Log
    Write-Host "`nERROR: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Log: $Log"
    exit 1
}
