# Plan técnico

## Archivos

- `.config/hypr/hyprland.conf`
- `.config/hypr/hypridle.conf`
- `.config/hypr/hyprsunset.conf` (nuevo)
- `spec/features/002-hyprland-improvements/tasks.md`
- `spec/features/002-hyprland-improvements/verify.md`

## Implementación

1. Extender `hyprland.conf` con:
   - autostart de `hyprsunset`;
   - permisos para `/usr/bin/grim` y `/usr/lib/xdg-desktop-portal-hyprland`;
   - `workspace_back_and_forth` y ocultación del workspace especial;
   - direct scanout automático;
   - movimiento preciso en `dwindle`;
   - gesto horizontal de tres dedos;
   - atajos de fullscreen/maximizado;
   - bloqueo con render inmediato.
2. Extender `hypridle.conf` con inhibición de suspensión hasta confirmar bloqueo, render inmediato y restauración explícita del brillo.
3. Crear perfiles Hyprsunset: identidad durante el día y 5500 K por la noche, sin gamma.
4. Verificar los archivos en el repositorio y después reemplazar la copia activa por un enlace, conservando un respaldo fechado.
5. Recargar Hyprland y comprobar sintaxis, opciones efectivas y procesos.
6. Registrar pruebas automáticas y comprobaciones manuales pendientes en `verify.md`.

## Verificación

- `hyprctl configerrors`
- `hyprctl getoption` para opciones configuradas
- `hyprctl binds`
- `hyprctl hyprsunset profile`
- `pgrep -a hypridle` y `pgrep -a hyprsunset`
- `git diff --check`
- Revisión del diff contra la spec

Las pruebas que requieran interacción (gestos, bloqueo, suspensión, capturas y screen sharing) se documentarán claramente si no pueden automatizarse sin interrumpir la sesión.

## Reversión

- Eliminar el enlace `~/.config/hypr` y restaurar el respaldo fechado creado durante esta implementación.
- Revertir por archivo solamente los cambios de esta feature; no descartar cambios ajenos.
