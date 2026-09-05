# Dotfiles

Respaldo reproducible de mi escritorio Arch Linux con Hyprland.

Este repositorio contiene configuraciones, temas, wallpapers, scripts y manifiestos de paquetes necesarios para reconstruir el entorno despues de una reinstalacion.

## Restauracion

En una instalacion nueva de Arch Linux:

```bash
sudo pacman -S --needed git
git clone https://github.com/hyprhelios/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

El instalador:

- Actualiza Arch Linux e instala los paquetes oficiales del manifiesto.
- Instala `yay` cuando no esta disponible e instala los paquetes AUR.
- Conserva configuraciones existentes con el sufijo `.backup.FECHA`.
- Crea enlaces simbolicos desde el repositorio hacia el directorio personal.
- No sobrescribe un enlace que ya apunta al archivo correcto.

El proceso pide confirmacion mediante `pacman`, `makepkg` o `yay` cuando corresponde. Al finalizar, se recomienda cerrar la sesion y volver a iniciar Hyprland.

Para usar Fish como shell predeterminado:

```bash
chsh -s "$(command -v fish)"
```

## Contenido

| Ruta | Contenido |
|------|-----------|
| `.config/hypr` | Hyprland, Hypridle, Hyprlock y tema activo |
| `.config/waybar` | Barra, modulos y colores |
| `.config/ghostty` | Terminal y tema generado |
| `.config/wofi` | Lanzador de aplicaciones |
| `.config/fuzzel` | Tema alternativo del lanzador |
| `.config/fish` | Shell, abreviaciones y funciones |
| `.config/nvim` | Neovim basado en LazyVim |
| `.config/btop` | Monitor del sistema y tema |
| `.local/bin` | Scripts de wallpaper y cambio de tema |
| `.local/share/dots-hyprland` | Tres temas y sus wallpapers |
| `packages/pacman.txt` | Paquetes oficiales instalados explicitamente |
| `packages/aur.txt` | Paquetes AUR instalados explicitamente |

## Temas

`Super + T` alterna entre los temas `barch`, `img1084` y `7ucM1Zw`. El script actualiza Hyprland, Hyprlock, Ghostty, Waybar, Wofi, Fuzzel y GTK usando los archivos de `.local/share/dots-hyprland`.

## Actualizar El Respaldo

Antes de copiar cambios al repositorio, revisar que no contengan secretos ni datos efimeros. Los manifiestos se regeneran con:

```bash
pacman -Qqen > ~/.dotfiles/packages/pacman.txt
pacman -Qqem > ~/.dotfiles/packages/aur.txt
```

Luego se revisan y publican los cambios:

```bash
cd ~/.dotfiles
git status
git diff
git add --all
git commit -m "Update system recovery dotfiles"
git push
```

## Seguridad

El repositorio es publico. No se deben versionar:

- Claves SSH o GPG.
- Tokens, contrasenas o archivos `.env`.
- Historial de comandos o sesiones de aplicaciones.
- Perfiles y caches de navegadores.
- Bases de datos personales de Obsidian u otras aplicaciones.

`fish_variables` se excluye porque puede almacenar variables universales y rutas especificas del equipo.

## Alcance

Los manifiestos reflejan el equipo actual e incluyen componentes de GNOME, Hyprland y controladores AMD. Antes de usarlos en hardware diferente conviene revisar `packages/pacman.txt`, especialmente microcodigo, controladores graficos y paquetes del kernel.
