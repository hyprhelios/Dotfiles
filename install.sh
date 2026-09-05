#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

if [[ ! -f /etc/arch-release ]]; then
    printf 'Este instalador solo es compatible con Arch Linux.\n' >&2
    exit 1
fi

read_packages() {
    local manifest="$1"
    local -n destination="$2"
    local package

    while IFS= read -r package; do
        [[ -z "$package" || "$package" == \#* ]] || destination+=("$package")
    done < "$manifest"
}

install_packages() {
    local pacman_packages=()
    local aur_packages=()

    read_packages "$DOTFILES_DIR/packages/pacman.txt" pacman_packages
    read_packages "$DOTFILES_DIR/packages/aur.txt" aur_packages

    printf 'Instalando %d paquetes oficiales...\n' "${#pacman_packages[@]}"
    sudo pacman -Syu --needed "${pacman_packages[@]}"

    if ! command -v yay >/dev/null 2>&1; then
        local build_dir
        build_dir="$(mktemp -d)"
        trap 'rm -rf -- "$build_dir"' RETURN
        git clone https://aur.archlinux.org/yay.git "$build_dir/yay"
        (
            cd "$build_dir/yay"
            makepkg -si
        )
        rm -rf -- "$build_dir"
        trap - RETURN
    fi

    printf 'Instalando %d paquetes AUR...\n' "${#aur_packages[@]}"
    yay -S --needed "${aur_packages[@]}"
}

link_item() {
    local source="$1"
    local destination="$2"

    mkdir -p -- "$(dirname -- "$destination")"

    if [[ -L "$destination" && "$(readlink -f -- "$destination")" == "$(readlink -f -- "$source")" ]]; then
        printf 'Ya enlazado: %s\n' "$destination"
        return
    fi

    if [[ -e "$destination" || -L "$destination" ]]; then
        local backup="${destination}.${BACKUP_SUFFIX}"
        printf 'Respaldo: %s -> %s\n' "$destination" "$backup"
        mv -- "$destination" "$backup"
    fi

    ln -s -- "$source" "$destination"
    printf 'Enlace: %s -> %s\n' "$destination" "$source"
}

install_packages

configs=(hypr waybar ghostty wofi fuzzel fish nvim btop)
for config in "${configs[@]}"; do
    link_item "$DOTFILES_DIR/.config/$config" "$HOME/.config/$config"
done

scripts=(set-wallpaper theme-cycle update-waybar-theme)
for script in "${scripts[@]}"; do
    link_item "$DOTFILES_DIR/.local/bin/$script" "$HOME/.local/bin/$script"
done

link_item \
    "$DOTFILES_DIR/.local/share/dots-hyprland" \
    "$HOME/.local/share/dots-hyprland"

printf '\nRestauracion terminada. Cierra la sesion y vuelve a iniciar Hyprland.\n'
printf 'Para usar Fish como shell: chsh -s "$(command -v fish)"\n'
