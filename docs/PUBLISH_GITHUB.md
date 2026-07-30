# Publicar cambios de NRMenu en GitHub

Esta guía asume que el repositorio ya está clonado y conectado a:

```text
https://github.com/NovenRetro/NRMenu
```

## 1. Copiar la actualización

Copiá el contenido del paquete de actualización sobre la raíz del repositorio local y aceptá reemplazar archivos.

No reemplaces ni borres:

```text
.git
```

## 2. Verificar los cambios

Desde PowerShell:

```powershell
cd C:\RUTA\A\NRMenu
git status
git diff --stat
git diff
```

Confirmá especialmente:

- `overrides/src/*.c` no cambió;
- las cuatro imágenes están en `docs/images`;
- `build.env` contiene el commit y digest fijados;
- no aparecen ROMs, saves o archivos personales.

## 3. Regenerar y validar el manifiesto

```powershell
.\scripts\update-manifest.ps1
.\scripts\verify-repository.ps1
```

La salida final debe incluir:

```text
MANIFEST OK
REPOSITORY OK
```

## 4. Compilar desde limpio

Abrí Docker Desktop y ejecutá:

```powershell
.\scripts\build.ps1 -Fresh
```

Debe generar:

```text
dist\OS64P_NRMENU_v1.0.1.v64
dist\OS64P_NRMENU_v1.0.1.v64.sha256
dist\BUILD_INFO.txt
```

## 5. Crear el commit

```powershell
git add .
git status
git commit -m "Prepare reproducible NRMenu v1.0.1 release"
git push origin main
```

## 6. Revisar GitHub Actions

1. Abrí la pestaña **Actions**.
2. Entrá en el workflow **Build NRMenu**.
3. Esperá que termine en verde.
4. Descargá el artifact.
5. Compará el hash del artifact con el build local.

## 7. Crear el tag

No muevas el tag `v1.0.0`.

```powershell
git tag -a v1.0.1 -m "NRMenu v1.0.1"
git push origin v1.0.1
```

## 8. Preparar los assets

Nombres recomendados:

```text
NRMenu-v1.0.1-OS64P.v64
NRMenu-v1.0.1-OS64P.v64.sha256
NRMenu-v1.0.1-BUILD_INFO.txt
NRMenu-v1.0.1-ED64Plus-ReadyToUse.zip
```

El paquete Ready to Use debe estar saneado y no contener:

- ROMs;
- BIOS;
- saves personales;
- `LASTROM.CFG`;
- Favoritos o Historial personales;
- carátulas comerciales sin autorización;
- emuladores de terceros sin licencia de redistribución.

## 9. Crear la Release

1. Abrí **Releases**.
2. Elegí **Draft a new release**.
3. Seleccioná `v1.0.1`.
4. Título: `NRMenu v1.0.1`.
5. Copiá y adaptá `docs/RELEASE_NOTES_1.0.1.md`.
6. Adjuntá los assets.
7. Marcala como **Latest release**.
8. Publicá.

## 10. Verificación posterior

- Abrí la Release sin iniciar sesión.
- Descargá el `.v64`.
- Confirmá el SHA-256.
- Descargá el Ready to Use y revisá su estructura.
- Verificá que el README muestre las cuatro capturas.
- Confirmá que el badge del workflow esté en verde.
