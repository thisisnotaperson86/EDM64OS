# Limitaciones conocidas

NRMenu modifica principalmente la interfaz. No corrige automáticamente todos los problemas históricos de ALTRA64.

## Heredadas de ALTRA64

Las releases públicas de ALTRA64 documentan, según versión y hardware:

- Los cheats pueden provocar cuelgues.
- Los juegos 64DD no guardan correctamente.
- FlashRAM tuvo problemas históricos. La release 3.8.1 informa mejoras, pero menciona que Cubivore puede colgarse tras Start y Pokémon Snap puede no conservar el save.
- Algunos juegos, como Custom Robo, fueron reportados sin guardado.
- La base de datos de juegos problemáticos no es completa; algunos títulos requieren CIC/save configurado manualmente con `C-Derecha`.
- La visualización de Mempaks tuvo falsos mensajes de “no formateado” en distintas revisiones.
- Algunas ROMs NES necesitan padding por una limitación de lectura del ED64 Plus.
- MSX, Game Gear y MP3 fueron reportados como no funcionales en releases antiguas, aunque la inyección manual podía funcionar en ciertos casos.
- El sonido o la música pueden producir lentitud en el menú.

Fuentes históricas:

- https://github.com/Suprapote/Altra64/releases
- https://github.com/ariahiro64/altra64/releases
- https://github.com/ariahiro64/altra64/issues

## Decisiones específicas de NRMenu

- Top 15 está deshabilitado porque era redundante con Favoritos y podía colgar el sistema.
- El borrado de archivos está deshabilitado.
- Las carátulas N64 usan un ID corto de dos caracteres; pueden existir colisiones.
- La carga de carátulas es deliberadamente diferida aproximadamente 900 ms.
- Máximo 64 Favoritos y 20 entradas de Historial.
- Favoritos e Historial dependen de que la ruta de la ROM no cambie.
- Renombrar o mover una ROM deja una entrada antigua hasta que sea eliminada/reemplazada.

## Guardados

El flujo de guardado de ALTRA64 normalmente requiere:

1. Guardar dentro del juego.
2. Presionar Reset físico.
3. Esperar que el menú copie la memoria a la SD.
4. Apagar recién después de volver completamente al menú.

Nunca validar un cambio de guardado con una partida importante sin backup.
