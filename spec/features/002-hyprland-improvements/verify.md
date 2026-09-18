# Verificación

Fecha: 2026-09-18

## Resultado

La configuración fue instalada, recargada y comprobada después de un reinicio completo de Hyprland. Las comprobaciones no interactivas pasan. Quedan como validación manual el gesto físico, el ciclo bloqueo/suspensión y el screen sharing desde una aplicación.

## Evidencia automática

| Comprobación | Resultado | Evidencia |
|---|---|---|
| Fuente de verdad | PASS | `~/.config/hypr` resuelve a `~/.dotfiles/.config/hypr`. Respaldo: `~/.config/hypr.backup.20260918160047`. |
| Sintaxis Hyprland | PASS | `hyprctl reload config-only` devolvió `ok`; `hyprctl configerrors` quedó vacío. |
| Opciones de workspaces | PASS | `workspace_back_and_forth=1` y `hide_special_on_workspace_change=1`, ambas con `set: true`. |
| Movimiento preciso | PASS | `dwindle:precise_mouse_move=1`, `set: true`. |
| Direct scanout automático | PASS | `render:direct_scanout=2`, `set: true`; en Hyprland 0.56.2 el mapa local es `0=disable`, `1=enable`, `2=auto`. |
| Atajos | PASS | `hyprctl binds` registra fullscreen con argumentos `0` y `1`, y bloqueo con `hyprlock --immediate-render`. |
| Maximizado | PASS | La ejecución controlada de `fullscreen 1` cambió el estado de la ventana activa de `0` a `1` y volvió a `0`, pese a la regla `suppressevent maximize`. |
| Hypridle | PASS | Cargó cuatro listeners y registró `Sleep inhibition enabled - inhibiting until the wayland session gets locked`. |
| Hyprsunset | PASS | Cargó dos perfiles; el perfil diurno informa identidad activa, temperatura 6000 y gamma 1. |
| Procesos | PASS | Hay una instancia de `hypridle` y una de `hyprsunset` después del autostart de Hyprland. |
| Permisos | PASS | Después del reinicio, `ecosystem:enforce_permissions=1`; `grim - >/dev/null` finalizó correctamente y XDPH está activo con screencopy y PipeWire inicializados. |
| Formato del diff | PASS | `git diff --check` no reportó errores. |

## Permisos después del reinicio

Las reglas no se aplicaron mediante una recarga normal, como advierte la documentación oficial. Después del reinicio completo se confirmó que la activación y las excepciones para `grim` y XDPH se cargaron juntas. La captura directa funciona y el portal está preparado para screen sharing.

## Validación manual pendiente

- Probar los atajos físicos `Print` y `Shift+Print`.
- Probar screen sharing mediante `xdg-desktop-portal-hyprland`.
- Probar el gesto horizontal de tres dedos.
- Probar `Super+L` y un ciclo de suspensión/reanudación cuando no haya trabajo sin guardar.
- Observar vídeo o una aplicación fullscreen; retirar direct scanout si aparecen artefactos.

## Verificación anti-alucinación

- Hyprland confirmó en ejecución todas las opciones añadidas y no reportó errores de parseo.
- `hyprlock --help` confirma la existencia de `--immediate-render` en la versión instalada.
- Hypridle 0.1.8 confirmó en sus propios logs la inhibición hasta recibir notificación de bloqueo.
- Hyprsunset 0.4.0 confirmó el parseo de ambos perfiles y la aplicación del perfil diurno.
- Las rutas permitidas existen: `/usr/bin/grim` y `/usr/lib/xdg-desktop-portal-hyprland`.
- No se migró a Lua, no se instalaron paquetes y no se cambiaron los tiempos de inactividad.

## Cross-review findings

La revisión independiente no encontró problemas críticos reales. Sus observaciones quedaron resueltas así:

- `direct_scanout=2`: confirmado como modo `auto` por `hyprctl descriptions`; no es modo forzado.
- `inhibit_sleep=3`: confirmado por los logs de Hypridle 0.1.8.
- `hyprsunset.conf` sin seguimiento: es un archivo nuevo dentro del repositorio; no se hizo `git add` porque la feature no incluye commits.
- Conflicto de maximizado: descartado mediante una prueba de alternancia y restauración del estado.
- Sintaxis de permisos, gesto y direct scanout: aceptada por Hyprland 0.56.2 y la recarga completa del archivo.

No quedan findings CRITICAL o HIGH. Permanecen únicamente las pruebas manuales descritas arriba.

## Reality-check

```text
REALITY-CHECK: NEEDS HUMAN
Reason: sintaxis, procesos, permisos, captura directa y portal pasan; los atajos físicos, gesto, bloqueo/suspensión y screen sharing requieren interacción humana.
Findings: 0 CRITICAL / 0 HIGH / 4 manual checks
```
