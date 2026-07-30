# Changelog

## 1.0.1

Revisión de infraestructura, reproducibilidad y documentación. El firmware continúa identificándose como **NRMenu v1.0**.

### Mejorado

- Commit exacto de ALTRA64 fijado en `build.env`.
- Imagen Docker fijada por digest SHA-256.
- Builds reproducibles en Windows, Linux/macOS y GitHub Actions.
- GitHub Actions actualizado a `actions/checkout@v5` y `actions/upload-artifact@v6`.
- Verificación pública del repositorio simplificada para permitir contribuciones reales.
- Comprobación de enlaces locales, configuración, capturas y archivos privados.
- Archivo `BUILD_INFO.txt` con la procedencia de cada compilación.
- README con instalación completa, actualización y capturas reales 2 × 2.
- Instalador y restaurador con letra de unidad configurable.
- Créditos upstream aclarados y separados.
- Limpieza de archivos usados únicamente durante la preparación inicial del repositorio.

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
