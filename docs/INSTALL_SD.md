# Instalar NRMenu en una tarjeta SD

## Opción A: paquete Ready to Use

Para una SD nueva:

1. descargá el paquete `NRMenu-v1.0.x-ED64Plus-ReadyToUse.zip` desde la [última Release](https://github.com/NovenRetro/NRMenu/releases/latest);
2. formateá la SD en FAT32;
3. extraé el contenido en la raíz;
4. agregá únicamente ROMs obtenidas legalmente;
5. expulsá la SD de forma segura.

El paquete público no debería incluir ROMs, BIOS, saves personales ni arte comercial sin autorización.

## Opción B: actualizar una instalación existente

### Requisitos previos

- Instalación funcional de ALTRA64/ED64 Plus.
- Tarjeta SD FAT32.
- Carpeta `ED64P` en la raíz.
- Binario compilado en:

```text
dist/OS64P_NRMENU_v1.0.1.v64
```

## Backup obligatorio

Antes de instalar, copiá toda la SD a una carpeta de la PC. Como mínimo respaldá:

```text
ED64P\OS64P.v64
ED64P\ALTRA64.INI
ED64P\SDSAVE
ED64P\NRDATA
ED64P\CFG
ED64P\MEMPAKS
```

## Instalación automática en Windows

Con la SD como `D:`:

```powershell
.\scripts\install-sd.ps1 -DriveLetter D
```

O doble clic:

```text
scripts\install-sd.cmd
```

El script:

- lee el nombre de salida desde `build.env`;
- verifica el ROM compilado;
- respalda el `OS64P.v64` anterior en `backups/`;
- reemplaza únicamente `D:\ED64P\OS64P.v64`;
- compara el SHA-256 de origen y destino.

## Instalación manual

1. Renombrá el menú anterior:

```text
D:\ED64P\OS64P.v64 → OS64P_BACKUP.v64
```

2. Copiá:

```text
dist\OS64P_NRMENU_v1.0.1.v64
```

3. Renombralo en la SD como:

```text
D:\ED64P\OS64P.v64
```

4. Expulsá la SD de forma segura.

## Primera prueba

1. Confirmar que aparece NRMenu.
2. Entrar a una carpeta y volver con `B`.
3. Cambiar Browser/Favoritos/Historial con `L/R`.
4. Esperar aproximadamente un segundo sobre una ROM y verificar carátula.
5. Probar `C-Abajo` con Favoritos.
6. Probar las tres páginas de `Z`.
7. Iniciar una ROM conocida.

## Restaurar el menú anterior

```powershell
.\scripts\restore-last.ps1 -DriveLetter D
```

No apagues la consola durante operaciones de guardado. Después de guardar dentro de un juego, presioná Reset y esperá el regreso completo al menú antes de apagar.
