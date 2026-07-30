Set-StrictMode -Version Latest

function Get-NRMenuBuildConfig {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Root
    )

    $ConfigPath = Join-Path $Root 'build.env'
    if (-not (Test-Path $ConfigPath)) {
        throw "No se encontró la configuración reproducible: $ConfigPath"
    }

    $Config = @{}
    foreach ($Line in Get-Content $ConfigPath) {
        $Trimmed = $Line.Trim()
        if (-not $Trimmed -or $Trimmed.StartsWith('#')) {
            continue
        }

        $Parts = $Trimmed -split '=', 2
        if ($Parts.Count -ne 2) {
            throw "Línea inválida en build.env: $Line"
        }

        $Config[$Parts[0].Trim()] = $Parts[1].Trim()
    }

    foreach ($Required in @(
        'NRMENU_RELEASE_VERSION',
        'NRMENU_FIRMWARE_LABEL',
        'NRMENU_OUTPUT_NAME',
        'ALTRA64_REPOSITORY',
        'ALTRA64_COMMIT',
        'ALTRA64_DOCKER_IMAGE'
    )) {
        if (-not $Config.ContainsKey($Required) -or -not $Config[$Required]) {
            throw "Falta $Required en build.env"
        }
    }

    if ($Config.ALTRA64_COMMIT -notmatch '^[0-9a-f]{40}$') {
        throw "ALTRA64_COMMIT no es un SHA completo de 40 caracteres."
    }

    if ($Config.ALTRA64_DOCKER_IMAGE -notmatch '@sha256:[0-9a-f]{64}$') {
        throw "ALTRA64_DOCKER_IMAGE debe estar fijada mediante digest sha256."
    }

    return $Config
}
