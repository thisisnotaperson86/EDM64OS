# Arquitectura de NRMenu v1.0

## Estrategia del repositorio

NRMenu se distribuye como una capa reproducible sobre ALTRA64:

```text
ariahiro64/altra64
        +
overrides/src/main.c
overrides/src/menu_about.c
overrides/src/menu_controls.c
        =
NRMenu v1.0
```

Esto evita duplicar todos los archivos heredados y mantiene visible qué piezas modifica NRMenu.

## Archivos modificados

### `main.c`

Contiene:

- Modos Browser/Favoritos/Historial.
- Caché del Browser.
- Persistencia de Favoritos e Historial.
- Vista previa diferida.
- Carátulas del panel derecho.
- Navegación entre pestañas.
- Corrección de carpeta padre.
- Disclaimer.
- Desactivación de Top 15 y borrado.
- Ventanas secundarias opacas.

### `menu_about.c`

Muestra:

- NRMenu v1.0.
- Base ALTRA64.
- Firmware ED64 detectado.
- Créditos de ALTRA64 y NovenRetro.

### `menu_controls.c`

Muestra los controles reales de NRMenu.

## Datos persistentes

```text
/ED64P/NRDATA/FAVORITES.TXT
/ED64P/NRDATA/HISTORY.TXT
```

Cada línea contiene la ruta completa de un juego.

Límites:

```text
Favoritos: 64
Historial: 20
```

## Modos de vista

```c
NR_VIEW_BROWSER
NR_VIEW_FAVORITES
NR_VIEW_HISTORY
```

Al salir del Browser se guardan en RAM:

- Carpeta actual.
- Cursor.
- Página.
- Lista de entradas.

Esto evita releer la carpeta al regresar desde Favoritos o Historial.

## Vista previa

El cambio de selección programa una carga pendiente. La imagen solo se procesa después de 15 ciclos del bucle principal. El menú duerme aproximadamente 60 ms por ciclo, por lo que la demora práctica ronda los 900 ms.

Para ROMs N64 se leen 512 bytes del encabezado para obtener:

- Título.
- Game ID.
- Región.
- Tamaño.
- Tipo de save según base de datos.

La carátula se decodifica desde PNG y se mantiene en caché mientras no cambie la selección.

## Funciones críticas conservadas

La revisión estable verificó que estas funciones permanecieran idénticas a la base funcional:

- `loadgenericrom()`
- `loadrom()`
- `backupSaveData()`
- `saveTypeFromSd()`
- `saveTypeToSd()`
- `bootRom()`
- `readRomConfig()`
- `readEmuConfig()`

Los hashes usados durante esa validación están en `docs/CRITICAL_FUNCTION_VALIDATION.txt`.

## Puntos recomendados para futuras mejoras

- Resolver boxart por CRC/Game ID completo.
- Caché LRU de varias carátulas.
- Demora configurable desde INI.
- Internacionalización completa.
- Eliminar código muerto de Top 15 después de pruebas exhaustivas.
- Pruebas automatizadas de parseo de rutas y listas.
- Integración con una base moderna como N64FlashcartMenu.
- Aclarar formalmente la licencia upstream.
