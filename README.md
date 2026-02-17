# Dotfiles

Mis dotfiles personales para Arch Linux con Hyprland (Wayland).

## Instalación

```bash
git clone https://github.com/hyprhelios/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# Los archivos se copian manualmente según necesidad
```

## Aplicaciones de Configuración

### Gestores de Ventanas / Compositor

| App | Descripción | Uso |
|-----|-------------|-----|
| **Hyprland** | Window manager tiling para Wayland, moderno y altamente configurable | `hyprland` para iniciar sesión |
| **Hypridle** | Demonio de inactividad para Hyprland (bloqueo de pantalla, suspensión) | Se inicia automáticamente con Hyprland |
| **Hyprlock** | Pantalla de bloqueo compatible con Hyprland | `hyprlock` o `Super + L` |
| **Hyprpaper** | Gestor de wallpaper para Wayland | Configurado en `hyprpaper.conf` |

### Terminales

| App | Descripción | Uso |
|-----|-------------|-----|
| **Kitty** | Terminal GPU moderna y rápida | `kitty` |
| **Ghostty** | Terminal de Zig (muy rápida, nativa Wayland) | `ghostty` |

### Shells

| App | Descripción | Uso |
|-----|-------------|-----|
| **Fish** | Shell interactiva y amigable | `fish` como shell por defecto |
| **Oh My Fish** | Framework para Fish | Plugins y temas para Fish |
| **atuin** | Historial de comandos mejorado con sync | `atuin search`, `Ctrl+R` |

### Neovim

| App | Descripción | Uso |
|-----|-------------|-----|
| **LazyVim** | Configuración de Neovim lista para usar | `nvim` |

### Herramientas del Sistema

| App | Descripción | Uso |
|-----|-------------|-----|
| **Waybar** | Barras de estado altamente configurables para Wayland | Se inicia con Hyprland |
| **Wofi** | Menú de aplicaciones estilo Wofi/Dmenu para Wayland | `Super + Espacio` |
| **btop** | Monitor de sistema visual (CPU, RAM, red, procesos) | `btop` |
| **fastfetch** | Información del sistema al estilo neofetch pero más rápido | `fastfetch` |
| **cava** | Visualizador de audio en terminal | `cava` |

### Navegadores

| App | Descripción | Uso |
|-----|-------------|-----|
| **Brave** | Navegador basado en Chromium con privacidad | `brave` |
| **Google Chrome** | Navegador de Google | `google-chrome` |

### Utilidades

| App | Descripción | Uso |
|-----|-------------|-----|
| **swww** | Gestor de wallpapers animado para Wayland | `swww-daemon`, `swww img` |
| **waypaper** | Interfaz para cambiar wallpapers | `waypaper --random` |
| **Hyprshot** | Herramienta de capturas de pantalla para Hyprland | `Super + Print` (pantalla), `Shift + Print` (región) |

### Aplicaciones de Audio

| App | Descripción | Uso |
|-----|-------------|-----|
| **EasyEffects** | EQ y efectos de audio para PulseAudio/PipeWire | `easyeffects` |
| **PulseAudio** | Servidor de audio (control con wpctl) | `wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+` |

## Atajos de Teclado (Hyprland)

| Atajo | Acción |
|-------|--------|
| `Super + Enter` | Abrir terminal (Ghostty) |
| `Super + Q` | Cerrar ventana activa |
| `Super + M` | Salir de Hyprland |
| `Super + E` | Explorador de archivos (Nautilus) |
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
| `Super + Fechas` | Mover foco entre ventanas |
| `Print` | Captura de pantalla (pantalla completa) |
| `Shift + Print` | Captura de pantalla (región) |

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
├── .bashrc, .bash_profile       # Config de Bash
├── .gitconfig                   # Config de Git
├── .config/
│   ├── hypr/                    # Hyprland + idle + lock
│   ├── kitty/                  # Terminal Kitty
│   ├── ghostty/                 # Terminal Ghostty
│   ├── nvim/                   # Neovim (LazyVim)
│   ├── fish/                   # Fish shell
│   ├── waybar/                 # Status bar
│   ├── wofi/                   # Menú de apps
│   ├── btop/                   # Monitor sistema
│   ├── fastfetch/              # Info sistema
│   └── ...
└── README.md
```
