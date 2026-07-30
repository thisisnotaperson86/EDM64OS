# Instalar NRMenu en una tarjeta SD

## Opción A: paquete Ready to Use

Para una SD nueva:

1. descargá el paquete indicado como **Ready to Use** en la [última Release](https://github.com/NovenRetro/NRMenu/releases/latest);
2. formateá la SD en FAT32;
3. extraé el contenido en la raíz;
4. agregá tus ROMs obtenidas legalmente;
5. expulsá la SD de forma segura.

El contenido exacto del paquete se informa en la Release. No incluye ROMs.

## Opción B: actualizar una instalación existente

### Requisitos previos

- Instalación funcional de ALTRA64 o NRMenu.
- Tarjeta SD FAT32.
- Carpeta `ED64P` en la raíz.
- Binario compilado en `dist/`.

## Backup

Antes de instalar, respaldá toda la SD. Como mínimo:

```text
ED64P\OS64P.v64
ED64P\ALTRA64.INI
ED64P\SDSAVE
ED64P\NRDATA
ED64P\CFG
ED64P\MEMPAKS
```

## Instalación automática en Windows

Indicá la letra asignada a la SD:

```powershell
.\scripts\install-sd.ps1 -DriveLetter E
```

O:

```bat
scripts\install-sd.cmd E
```

Si ejecutás el `.cmd` sin argumento, solicitará la letra.

El script:

- lee el nombre de salida desde `build.env`;
- verifica el ROM compilado;
- respalda el `OS64P.v64` anterior en `backups/`;
- reemplaza únicamente `E:\ED64P\OS64P.v64`;
- compara el SHA-256 de origen y destino.

## Instalación manual

1. Renombrá el menú anterior como `OS64P_BACKUP.v64`.
2. Copiá el `.v64` generado en `dist/`.
3. Renombralo en la SD como `ED64P\OS64P.v64`.
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

```bat
scripts\restore-last.cmd E
```

O ejecutá el comando sin letra para que la solicite.

Después de guardar dentro de un juego, presioná Reset y esperá el regreso completo al menú antes de apagar.
