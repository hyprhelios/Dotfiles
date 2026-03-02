# Dotfiles

Mis dotfiles personales para Arch Linux con Hyprland (Wayland).

## Instalación Automática

```bash
git clone https://github.com/hyprhelios/Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
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
```

Los archivos se copian manualmente a `~/.config/`

## Configuraciones Incluidas

| App | Descripción |
|-----|-------------|
| **Fish** | Shell interactiva con Oh My Fish |
| **Neovim** | Editor basado en LazyVim |
| **Fastfetch** | Información del sistema |
| **CAVA** | Visualizador de audio para waybar |
| **Atuin** | Historial mejorado para shell |
| **Waypaper** | Gestor de wallpapers |

## Aplicaciones Instaladas (sin config en repo)

El installer instala estas apps pero sus configs están en otro repositorio:

| App | Descripción | Paquete |
|-----|------------|---------|
| **Hyprland** | Window manager tiling Wayland | `hyprland` |
| **Ghostty** | Terminal moderna | `ghostty` (AUR) |
| **Waybar** | Barra de estado | `waybar` |
| **Wofi** | Menú de apps | `wofi` |
| **Btop** | Monitor sistema | `btop` |
| **Brave** | Navegador | `brave` |
| **Google Chrome** | Navegador | `google-chrome` (AUR) |

## Atajos de Teclado (Hyprland)

| Atajo | Acción |
|-------|--------|
| `Super + Enter` | Abrir terminal |
| `Super + Q` | Cerrar ventana |
| `Super + M` | Salir de Hyprland |
| `Super + Espacio` | Menú de apps |
| `Super + F` | Pantalla completa |
| `Super + 1-0` | Cambiar workspace |
| `Super + Shift + 1-0` | Mover a workspace |
| `Print` | Captura de pantalla |

## Alias Útiles (Fish)

```fish
alias syu="sudo pacman -Syu"
alias s="sudo pacman -S"
alias n="nvim"
alias ls="eza --icons"
alias ll="eza -la --icons"
```

## Estructura de Archivos

```
.
├── install.sh
├── README.md
└── .config/
    ├── atuin/          # Historial shell
    ├── cava/           # Visualizador audio
    ├── fastfetch/     # Info sistema
    ├── fish/          # Shell config
    ├── nvim/          # Neovim (LazyVim)
    └── waypaper/      # Wallpaper manager
```

## Dependencias

### AUR Helper
- `yay`

### Paquetes Principales
- `hyprland`, `fish`, `neovim`, `waybar`, `wofi`, `btop`
- `fastfetch`, `cava`, `easyeffects`, `yazi`
- `brave`, `ghostty` (AUR), `google-chrome` (AUR)

### Utilidades
- `eza`, `bat`, `fzf`, `zoxide`, `fd`, `ripgrep`
- `playerctl`, `brightnessctl`, `networkmanager`
