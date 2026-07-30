# Changelog

## 1.0.1

Revisión de infraestructura, reproducibilidad y documentación. El firmware funcional continúa identificándose como **NRMenu v1.0** y los tres overrides C permanecen sin cambios.

### Mejorado

- Commit exacto de ALTRA64 fijado en `build.env`.
- Imagen Docker fijada por digest SHA-256.
- Builds de Windows, Linux/macOS y GitHub Actions reproducibles.
- GitHub Actions actualizado a `actions/checkout@v5` y `actions/upload-artifact@v6`.
- Verificación automática del repositorio y de los tres overrides estables.
- Generación y validación automática de `MANIFEST_SHA256.txt`.
- Archivo `BUILD_INFO.txt` con procedencia completa de cada compilación.
- README con instalación completa, actualización, capturas reales 2 × 2 y enlaces de Release.
- Documentación de publicación y mantenimiento ampliada.
- Nombres de artefactos preparados para la release `v1.0.1`.

### Conservado

- `overrides/src/main.c`
- `overrides/src/menu_about.c`
- `overrides/src/menu_controls.c`
- Comportamiento del firmware NRMenu v1.0 validado en hardware.

## 1.0.0

Primera versión pública estable de NRMenu.

### Agregado

- Navegador de dos paneles.
- Vista previa de carátula e información.
- Demora aproximada de 900 ms antes de cargar la carátula.
- Browser, Favoritos e Historial con `L/R`.
- Favoritos persistentes: máximo 64.
- Historial persistente: máximo 20.
- Caché del navegador al cambiar de pestaña.
- Pantallas de información, controles y aviso de uso.
- Fondos sólidos en ventanas secundarias.
- Corrección de regreso a la carpeta padre con `B`.

### Cambiado

- `C-Abajo` administra Favoritos.
- Top 15 deshabilitado.
- Eliminación de archivos deshabilitada.
- Panel principal con texto blanco, secundarios gris claro, selección azul petróleo y paneles oscuros.

### Conservado desde ALTRA64

- Carga de ROMs N64.
- Carga de emuladores.
- Detección y configuración de CIC/save.
- Copia de partidas al volver mediante Reset.
- Configuración mediante `ALTRA64.INI`.
