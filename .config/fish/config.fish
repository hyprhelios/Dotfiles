if status is-interactive
    # --- 0. PATH ---
    set -g fish_user_paths $HOME/.local/bin $fish_user_paths

    # --- 1. INICIALIZACIÓN DEL SISTEMA ---
    set -g fish_greeting "" # Elimina el saludo por defecto
    fastfetch # Información del sistema al inicio
    zoxide init fish | source # Inicializa 'z' para saltos rápidos

    # --- 2. GESTIÓN DE PAQUETES Y SISTEMA (TUS ALIAS) ---
    alias syu="sudo pacman -Syu"
    alias s="sudo pacman -S"
    alias deleted="sudo pacman -Rns"
    alias auditor="sudo lynis audit system"
    alias off="sudo poweroff"
    
    # Función segura para rm -rf con confirmación
    function r
        if test (count $argv) -eq 0
            echo "Usage: r <file>... (requires confirmation)"
            return 1
        end
        read -p "Confirm rm -rf (y/N): " confirm
        if test "$confirm" = "y"
            command rm -rf $argv
        else
            echo "Aborted"
        end
    end

    # --- 3. ATAJOS DE APLICACIONES ---
    alias n="nvim"
    alias ranger="yazi" # Reemplazo moderno de ranger
    alias anime="ani-cli"
    alias cat='bat' # Cat mejorado con colores

    # --- 4. ALIAS DE NAVEGACIÓN Y EZA (PERSONALIZADO) ---
    # ls: Básico con iconos
    alias ls="eza --icons --group-directories-first"

    # ll: Lista detallada MINIMALISTA (Solo tamaño, nombre e icono)
    alias ll="eza --icons --long --header --no-permissions --no-user --no-time --group-directories-first"

    # la: Igual que ll pero incluye archivos ocultos
    alias la="eza --icons --long --header --all --no-permissions --no-user --no-time --group-directories-first"

    # lx: Lista completa (permisos, usuario, grupo, tamaño, fecha, iconos)
    alias lx="eza --icons --long --header --group-directories-first"

    # --- 5. ALIAS COMPLEJOS (TUS SCRIPTS) ---
    alias seeker="cd ~/seeker; and python3 seeker.py"
    alias link="ssh -R 80:localhost:8080 nokey@localhost.run"
    alias bot="cd $PROYECTO_BOT_PATH; and source venv/bin/activate.fish"

    # --- 6. STREAMING (TWITCH) ---
    alias leo='npv gohuntleo'
    alias 666='npv shadoune666'
    alias cold='npv coldified'
    alias aurigas='npv aurigas'
    alias juja='npv jujalag'
    alias rubius='npv rubius'
    alias ibai='npv ibai'

    # --- 7. CONFIGURACIÓN FZF (MODO NINJA) ---
    # Activa los atajos Ctrl+R, Ctrl+T, Alt+C
    fzf_key_bindings

    # Configuración de búsqueda con 'fd' (Ignora basura como .git y node_modules)
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'

    # CORRECCIÓN: Estilos en una sola línea para máxima compatibilidad
    set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --color=header:#f1fa8c,info:#bd93f9,pointer:#50fa7b,marker:#ff79c6,spinner:#ffb86c,prompt:#bd93f9,fg+:#f8f8f2"

    # --- 8. FUNCIONES AVANZADAS (FZF + EZA + ZOXIDE) ---

    # [fzp] - Previsualizar archivos
    function fzp
        fzf --preview "bat --style=numbers --color=always --line-range :500 {}"
    end

    # [fzn] - Buscar y abrir en NEOVIM
    function fzn
        set -l file (fzf --preview "bat --style=numbers --color=always --line-range :500 {}")
        if test -n "$file"
            nvim $file
        end
    end

    # [fzz] - Navegar subdirectorios usando ZOXIDE + EZA Preview
    # Busca carpetas recursivamente y salta a ellas con 'z' para actualizar el historial
    function fzz
        set -l dir (fd --type d --hidden --exclude .git | fzf --preview "eza --tree --level=2 --icons=always --color=always {}")
        if test -n "$dir"
            z $dir
        end
    end
end
