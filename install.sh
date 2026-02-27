#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"
aur_helper="yay"

echo "============================================"
echo "  Instalador de Dotfiles - Hyprland"
echo "============================================"
echo ""

if [ "$(uname -r)" != "Arch" ] && [ ! -f /etc/arch-release ]; then
    echo "Este script está diseñado para Arch Linux."
    exit 1
fi

install_aur_package() {
    if $aur_helper -Q "$1" &>/dev/null; then
        echo "  ✓ $1 ya instalado"
    else
        echo "  ↳ Instalando $1..."
        $aur_helper -S --noconfirm "$1" || echo "  ⚠ Error instalando $1"
    fi
}

install_pacman_package() {
    if pacman -Q "$1" &>/dev/null; then
        echo "  ✓ $1 ya instalado"
    else
        echo "  ↳ Instalando $1..."
        sudo pacman -S --noconfirm "$1" || echo "  ⚠ Error instalando $1"
    fi
}

echo ">> Instalando dependencias base..."
sudo pacman -Sy --noconfirm

echo ""
echo ">> Instalando aplicaciones principales (pacman)..."

packages_pacman=(
    "hyprland"
    "fish"
    "neovim"
    "waybar"
    "wofi"
    "btop"
    "fastfetch"
    "cava"
    "easyeffects"
    "yazi"
    "brave"
    "swww"
    "zoxide"
    "fzf"
    "eza"
    "bat"
    "fd"
    "ripgrep"
    "git"
    "curl"
    "wget"
    "playerctl"
    "brightnessctl"
    "networkmanager"
    "polkit-kde-agent"
    "xdg-desktop-portal-hyprland"
    "qt5-wayland"
    "qt6-wayland"
    "pipewire"
    "wireplumber"
    "pavucontrol"
    "pamixer"
    "ttf-jetbrains-mono-nerd"
    "ttf-font-awesome"
    "dunst"
    "nautilus"
)

for pkg in "${packages_pacman[@]}"; do
    install_pacman_package "$pkg"
done

echo ""
echo ">> Instalando aplicaciones (AUR)..."

if ! command -v $aur_helper &> /dev/null; then
    echo "  ↳ Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
fi

packages_aur=(
    "ghostty"
    "google-chrome"
    "waypaper"
    "hyprshot"
    "atuin"
    "spicetify-power-bar"
)

for pkg in "${packages_aur[@]}"; do
    install_aur_package "$pkg"
done

echo ""
echo ">> Clonando dotfiles..."
if [ -d "$DOTFILES_DIR" ]; then
    echo "  ↳ Actualizando repositorio existente..."
    cd "$DOTFILES_DIR"
    git pull
else
    git clone https://github.com/hyprhelios/Dotfiles.git "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
fi

echo ""
echo ">> Creando symlinks..."

link_config() {
    local src="$DOTFILES_DIR/$1"
    local dest="$HOME/$1"
    
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ -L "$dest" ]; then
            local current_target=$(readlink -f "$dest")
            if [ "$current_target" = "$src" ]; then
                echo "  ✓ $1 ya linked"
                return
            fi
        fi
        echo "  ⚠ Backup y linking $1..."
        mv "$dest" "$dest.backup.$(date +%s)"
    fi
    echo "  ↳ Linking $1..."
    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
}

link_config ".config/fastfetch"
link_config ".config/fish"
link_config ".config/hypr"
link_config ".config/nvim"
link_config ".config/waybar"
link_config ".config/wofi"
link_config ".config/btop"
link_config ".config/cava"
link_config ".bashrc"
link_config ".bash_profile"
link_config ".gitconfig"
link_config ".yarnrc"

echo ""
echo ">> Configurando shell por defecto..."
if command -v fish &> /dev/null; then
    if [ "$SHELL" != "$(which fish)" ]; then
        echo "  ↳ Cambiando shell a fish..."
        sudo chsh -s "$(which fish)"
    fi
fi

echo ""
echo ">> Instalando Oh My Fish..."
if [ ! -d "$HOME/.local/share/omf" ]; then
    curl -sL https://get.oh-my.fish | fish
fi

echo ""
echo "============================================"
echo "  Instalación completada!"
echo "============================================"
echo ""
echo "Próximos pasos:"
echo "  1. Reinicia tu sesión"
echo "  2. Inicia Hyprland con: Hyprland"
echo "  3. Configura tu monitor en ~/.config/hypr/monitors.conf"
echo ""
