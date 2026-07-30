param([switch]$Fresh)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
. (Join-Path $PSScriptRoot 'common.ps1')
$Config = Get-NRMenuBuildConfig -Root $Root

$Work = Join-Path $Root 'work\altra64'
$ExportRoot = Join-Path $Root 'export'
$Dest = Join-Path $ExportRoot "NRMenu-v$($Config.NRMENU_RELEASE_VERSION)-full-source"

& (Join-Path $PSScriptRoot 'bootstrap.ps1') -Fresh:$Fresh

if (Test-Path $Dest) {
    Remove-Item $Dest -Recurse -Force
}

New-Item -ItemType Directory -Force $ExportRoot | Out-Null

$ExcludeDirs = @('.git', 'bin', 'obj')
robocopy $Work $Dest /E /XD $ExcludeDirs /XF '*.o' '*.d' | Out-Null
if ($LASTEXITCODE -ge 8) {
    throw "Robocopy falló con código $LASTEXITCODE"
}

Copy-Item (Join-Path $Root 'README.md') (Join-Path $Dest 'README_NRMENU.md') -Force
Copy-Item (Join-Path $Root 'CREDITS.md') (Join-Path $Dest 'CREDITS_NRMENU.md') -Force
Copy-Item (Join-Path $Root 'LICENSE.md') (Join-Path $Dest 'LICENSE_STATUS_NRMENU.md') -Force
Copy-Item (Join-Path $Root 'NOTICE.md') (Join-Path $Dest 'NOTICE_NRMENU.md') -Force
Copy-Item (Join-Path $Root 'build.env') (Join-Path $Dest 'NRMENU_BUILD_PROVENANCE.env') -Force
Copy-Item (Join-Path $Root 'docs') (Join-Path $Dest 'docs-nrmenu') -Recurse -Force

Write-Host "FUENTE COMPLETA EXPORTADA: $Dest" -ForegroundColor Green
Write-Host "ALTRA64 commit: $($Config.ALTRA64_COMMIT)"
Write-Host 'Revisar la situación de licencia antes de publicar esta variante.'
