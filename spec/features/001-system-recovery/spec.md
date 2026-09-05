# Recuperacion completa del sistema

## Objetivo

Mantener un respaldo publico y reproducible de la configuracion actual de Arch Linux para reducir el trabajo manual despues de una reinstalacion.

## Alcance

- Respaldar la configuracion activa de Hyprland, Hypridle, Hyprlock, Waybar, Ghostty, Wofi, Fuzzel, Fish, Neovim y Btop.
- Respaldar los scripts personales requeridos por esas configuraciones.
- Registrar por separado los paquetes oficiales y AUR instalados explicitamente.
- Proveer un instalador idempotente que instale dependencias y cree enlaces simbolicos conservando configuraciones existentes.
- Documentar el proceso de instalacion y recuperacion.
- Configurar el repositorio para usar GitHub mediante SSH.

## Fuera de alcance

- Historiales, caches, sesiones de navegador y bases de datos de aplicaciones.
- Claves SSH, tokens, contrasenas y otros secretos.
- Datos personales de aplicaciones no necesarios para reconstruir el escritorio.
- Restauracion automatica de hardware, particiones o credenciales.

## Criterios de aceptacion

1. Las configuraciones activas seleccionadas estan versionadas y no contienen secretos detectables.
2. Todos los archivos locales referenciados por Hyprland que sean necesarios para iniciar el escritorio estan respaldados o documentados.
3. Los paquetes oficiales y AUR instalados explicitamente se pueden instalar desde manifiestos separados.
4. El instalador valida Arch Linux, instala paquetes sin provocar una actualizacion parcial y conserva archivos locales antes de enlazar dotfiles.
5. El README explica instalacion, contenido, restauracion y tratamiento de secretos.
6. Los scripts modificados superan validaciones sintacticas y el repositorio no contiene archivos efimeros conocidos.
