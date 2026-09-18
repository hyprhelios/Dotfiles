# Feature 002: Mejoras útiles de Hyprland

## Objetivo

Adaptar el escritorio Hyprland del portátil para mejorar productividad, apariencia útil, privacidad y rendimiento sin introducir plugins ni ampliar el alcance fuera del ecosistema Hypr.

## Contexto

- Hyprland 0.56.2 con proveedor de configuración Hyprlang.
- Pantalla interna `eDP-1` de 1366x768 a 60 Hz y GPU AMD Radeon R4/R5.
- Configuración reproducible almacenada en `~/.dotfiles/.config/hypr`.
- La configuración activa `~/.config/hypr` es una copia regular aunque el instalador exige que sea un enlace al repositorio.
- `hyprsunset`, `hyprland-guiutils`, `hyprshot`, `grim` y `xdg-desktop-portal-hyprland` ya están instalados.

## Alcance

1. Restaurar `~/.dotfiles/.config/hypr` como única fuente de verdad mediante el enlace previsto por `install.sh`.
2. Añadir navegación gestual y atajos de pantalla completa/maximizado.
3. Mejorar el comportamiento de workspaces y el movimiento de ventanas.
4. Añadir perfiles diurno/nocturno de Hyprsunset sin alterar gamma.
5. Activar permisos de Hyprland conservando capturas y screen sharing mediante aplicaciones confiables.
6. Reforzar el bloqueo previo a suspensión y la recuperación de pantalla/brillo.
7. Habilitar direct scanout en modo automático, sujeto a validación y reversión si causa regresiones.

## Fuera de alcance

- Migrar la configuración completa de Hyprlang a Lua.
- Instalar plugins o paquetes nuevos.
- Modificar Waybar, Wofi u otros componentes ajenos al ecosistema Hypr.
- Cambiar los tiempos actuales de inactividad, bloqueo, DPMS o suspensión.
- Activar blur, sombras o efectos costosos para la GPU.

## Criterios de aceptación

1. `~/.config/hypr` apunta a `~/.dotfiles/.config/hypr` y la configuración previa queda respaldada.
2. Hyprland recarga sin errores de configuración.
3. `Super+F` alterna fullscreen y `Super+Shift+F` alterna maximizado.
4. El gesto horizontal de tres dedos cambia de workspace.
5. Repetir el atajo del workspace actual regresa al workspace anterior y cambiar de workspace oculta el workspace especial.
6. Hyprsunset arranca una sola vez y dispone de perfiles diurno/nocturno sin modificar gamma.
7. El sistema de permisos permite capturas mediante `grim` y screen sharing mediante XDPH; el resto conserva los valores seguros predeterminados.
8. Hypridle espera la confirmación del bloqueo antes de suspender y restaura DPMS y brillo al reanudar.
9. Direct scanout queda en modo automático únicamente si no introduce errores de configuración ni regresiones observables.

## Restricciones

- Usar sintaxis Hyprlang compatible con Hyprland 0.56.2.
- No versionar secretos ni información personal.
- Aplicar cambios mínimos y mantener intactos los atajos y tiempos existentes salvo lo especificado.
