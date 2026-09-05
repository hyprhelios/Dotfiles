if status is-interactive
    # --- 0. PATH ---
    set -g fish_user_paths $HOME/.local/bin $fish_user_paths

    # --- 1. INICIALIZACIÓN DEL SISTEMA ---
    set -g fish_greeting ""
    fastfetch
    zoxide init fish | source

    # --- 2. GESTIÓN DE PAQUETES Y SISTEMA ---
    alias syu "sudo pacman -Syu"
    alias s "sudo pacman -S"
    alias deleted "sudo pacman -Rns"
    alias auditor "sudo lynis audit system"
    alias off "sudo poweroff"

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
    alias ranger="yazi"
    alias anime="ani-cli"
    alias cat='bat'

    # --- 4. ALIAS DE NAVEGACIÓN Y EZA ---
    alias ls="eza --icons --group-directories-first"
    alias ll="eza --icons --long --header --no-permissions --no-user --no-time --group-directories-first"
    alias la="eza --icons --long --header --all --no-permissions --no-user --no-time --group-directories-first"
    alias lx="eza --icons --long --header --group-directories-first"

    # --- 5. ALIAS COMPLEJOS ---
    alias seeker="cd ~/seeker; and python3 seeker.py"
    alias link="ssh -R 80:localhost:8080 nokey@localhost.run"
    set -q PROYECTO_BOT_PATH; or set -gx PROYECTO_BOT_PATH $HOME/.local/share/bot-proyecto
    alias bot="cd $PROYECTO_BOT_PATH; and source venv/bin/activate.fish"

    # --- 6. STREAMING (TWITCH) - solo si npv existe ---
    if command -q npv
        alias leo='npv gohuntleo'
        alias 666='npv shadoune666'
        alias cold='npv coldified'
        alias aurigas='npv aurigas'
        alias juja='npv jujalag'
        alias rubius='npv rubius'
        alias ibai='npv ibai'
    end

    # --- 7. CONFIGURACIÓN FZF ---
    fzf_key_bindings
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --exclude .git'
    set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --color=header:#f1fa8c,info:#bd93f9,pointer:#50fa7b,marker:#ff79c6,spinner:#ffb86c,prompt:#bd93f9,fg+:#f8f8f2"

    # --- 8. FUNCIONES AVANZADAS (FZF + EZA + ZOXIDE) ---
    function fzp
        fzf --preview "bat --style=numbers --color=always --line-range :500 {}"
    end

    function fzn
        set -l file (fzf --preview "bat --style=numbers --color=always --line-range :500 {}")
        if test -n "$file"
            nvim $file
        end
    end

    function fzz
        set -l dir (fd --type d --hidden --exclude .git | fzf --preview "eza --tree --level=2 --icons=always --color=always {}")
        if test -n "$dir"
            z $dir
        end
    end
end
set -gx PATH $HOME/.opencode/bin $PATH
