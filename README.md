# Dotfiles

Mis dotfiles personales para Arch Linux con Hyprland (Wayland).

## Instalación Automática

```bash
# Clonar el repositorio
git clone https://github.com/hyprhelios/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Ejecutar el script de instalación
chmod +x install.sh
./install.sh
```

El script instalará:
- Todas las aplicaciones necesarias (pacman + AUR)
- Las configuraciones como symlinks
- Oh My Fish
- Configurará Fish como shell por defecto

## Instalación Manual

```bash
git clone https://github.com/hyprhelios/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# Los archivos se copian manualmente según necesidad
```

## Aplicaciones de Configuración

### Gestores de Ventanas / Compositor

| App | Descripción | Paquete |
|-----|------------|---------|
| **Hyprland** | Window manager tiling para Wayland | `hyprland` |
| **Hypridle** | Demonio de inactividad | incluidos en hyprland |
| **Hyprlock** | Pantalla de bloqueo | incluidos en hyprland |
| **Hyprpaper** | Gestor de wallpaper | incluidos en hyprland |

### Terminales

| App | Descripción | Paquete |
|-----|------------|---------|
| **Kitty** | Terminal GPU moderna | `kitty` |
| **Ghostty** | Terminal de Zig | `ghostty` (AUR) |

### Shells

| App | Descripción | Paquete |
|-----|------------|---------|
| **Fish** | Shell interactiva | `fish` |
| **Oh My Fish** | Framework para Fish | [get.oh-my.fish](https://get.oh-my.fish) |
| **atuin** | Historial mejorado | `atuin` (AUR) |

### Neovim

| App | Descripción | Paquete |
|-----|------------|---------|
| **LazyVim** | Configuración de Neovim | `neovim` |

### Herramientas del Sistema

| App | Descripción | Paquete |
|-----|------------|---------|
| **Waybar** | Barras de estado | `waybar` |
| **Wofi** | Menú de aplicaciones | `wofi` |
| **btop** | Monitor de sistema | `btop` |
| **fastfetch** | Info sistema | `fastfetch` |
| **cava** | Visualizador de audio | `cava` |

### Navegadores

| App | Descripción | Paquete |
|-----|------------|---------|
| **Brave** | Navegador | `brave` |
| **Google Chrome** | Navegador | `google-chrome` (AUR) |

### Utilidades

| App | Descripción | Paquete |
|-----|------------|---------|
| **swww** | Wallpapers animados | `swww` |
| **waypaper** | Interfaz wallpapers | `waypaper` (AUR) |
| **Hyprshot** | Capturas de pantalla | `hyprshot` (AUR) |

### Aplicaciones de Audio

| App | Descripción | Paquete |
|-----|------------|---------|
| **EasyEffects** | EQ y efectos | `easyeffects` |
| **PipeWire** | Servidor de audio | `pipewire` |

## Atajos de Teclado (Hyprland)

| Atajo | Acción |
|-------|--------|
| `Super + Enter` | Abrir terminal (Ghostty) |
| `Super + Q` | Cerrar ventana activa |
| `Super + M` | Salir de Hyprland |
| `Super + E` | Explorador de archivos |
| `Super + Espacio` | Menú de aplicaciones (Wofi) |
| `Super + V` | Ventana flotante |
| `Super + P` | Pseudotiling |
| `Super + J` | Alternar split |
| `Super + L` | Bloquear pantalla |
| `Super + B` | Abrir navegador |
| `Super + D` | Abrir Discord |
| `Super + C` | Abrir editor de código |
| `Super + F` | Pantalla completa |
| `Super + 1-0` | Cambiar workspace |
| `Super + Shift + 1-0` | Mover ventana a workspace |
| `Print` | Captura de pantalla |
| `Shift + Print` | Captura de región |

## Volumen y Brillo

| Atajo | Acción |
|-------|--------|
| `XF86AudioRaiseVolume` | Subir volumen 5% |
| `XF86AudioLowerVolume` | Bajar volumen 5% |
| `XF86AudioMute` | Silenciar |
| `XF86MonBrightnessUp` | Subir brillo |
| `XF86MonBrightnessDown` | Bajar brillo |

## Alias Útiles (Fish)

```fish
alias syu="sudo pacman -Syu"      # Actualizar sistema
alias s="sudo pacman -S"          # Instalar paquete
alias n="nvim"                    # Neovim
alias ls="eza --icons"           # Lista con iconos
alias ll="eza -l --icons"        # Lista detallada
la="eza -la --icons"             # Lista con ocultos
```

## Estructura de Archivos

```
.
├── install.sh                   # Script de instalación
├── .bashrc, .bash_profile       # Config de Bash
├── .gitconfig                   # Config de Git
├── .yarnrc                      # Config de Yarn
├── .config/
│   ├── hypr/                    # Hyprland + idle + lock
│   ├── kitty/                   # Terminal Kitty
│   ├── ghostty/                 # Terminal Ghostty
│   ├── nvim/                    # Neovim (LazyVim)
│   ├── fish/                    # Fish shell
│   ├── waybar/                  # Status bar
│   ├── wofi/                    # Menú de apps
│   ├── btop/                    # Monitor sistema
│   ├── fastfetch/               # Info sistema
│   └── ...
└── README.md
```
