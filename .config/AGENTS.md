# AGENTS.md - ~/.config Development Guide

Guidelines for agentic coding agents working with the configuration files in this directory.

---

## 1. Project Overview

This is a **dotfiles** repository containing configuration files for:
- **Desktop**: Hyprland, Hypridle, Hyprlock, Waybar
- **Shell**: Fish Shell
- **Terminal**: Ghostty
- **Launchers**: Wofi and Fuzzel
- **Editor**: Neovim
- **System monitor**: Btop

---

## 2. Directory Structure

```
~/.config/
├── hypr/                  # Hyprland, Hypridle, and Hyprlock
├── waybar/                # Status bar
├── ghostty/               # Terminal
├── wofi/                  # Application launcher
├── fuzzel/                # Alternate launcher theme
├── fish/                  # Fish Shell config
├── nvim/                  # Neovim (LazyVim)
└── btop/                  # System monitor
```

---

## 3. Configuration Files by Type

### Fish Shell (.fish)
**Location**: `fish/config.fish`

```fish
# Key patterns:
# - Always wrap in 'if status is-interactive' for performance
# - Use functions instead of aliases for dangerous commands
# - Use $HOME instead of ~

# BAD: alias r="rm -rf"
# GOOD: function r with confirmation
function r
    if test (count $argv) -eq 0
        echo "Usage: r <file>..."
        return 1
    end
    read -p "Confirm rm -rf (y/N): " confirm
    if test "$confirm" = "y"
        command rm -rf $argv
    end
end
```

### JSON (.json, .jsonc)
- Use `.jsonc` for JSON with comments
- Validate: `python3 -m json.tool file.json > /dev/null`

### TOML (.toml)
- Location: `nvim/stylua.toml`

---

## 4. Code Style Guidelines

### Formatting

| File Type | Max Line | Indentation | Comments |
|-----------|----------|--------------|----------|
| .fish     | 120      | 4 spaces     | `#`      |
| .json/.jsonc | 120   | 2 spaces    | `//`     |
| .toml     | 120      | 4 spaces     | `#`      |

### Naming Conventions

- **Environment Variables**: UPPER_SNAKE_CASE
- **Functions**: snake_case
- **Aliases**: lowercase
- **Files**: lowercase with underscores

### Path Handling

- Use `$HOME` instead of `~` for shell compatibility
- Avoid hardcoded absolute paths like `/home/username`

---

## 5. Validation Commands

### Fish Shell
```bash
fish -n config.fish
```

### JSON/JSONC
```bash
python3 -m json.tool file.json > /dev/null
```

---

## 6. Security Considerations

- **NEVER** hardcode passwords, API keys, or tokens
- Use environment variables for secrets
- `fish/config.fish` has a safe `r` function with confirmation

---

## 7. Portability

- Configs tuned for **Arch Linux** with **Wayland**
- WM: Wayland (Sway/Hyprland)
- Terminal: Ghostty

---

## 8. Testing Changes

After modifying any config file:

1. **Validate syntax** using Section 5 commands
2. **Reload**: Fish `source ~/.config/fish/config.fish` or restart app
3. **Check for errors** in application output

---

## 9. Dependencies

- Fish Shell 3.0+
- Hyprland, Hypridle, Hyprlock, and Hyprpaper
- Waybar, Ghostty, Wofi, and Fuzzel
- Fish, Neovim, and Btop
- Tools: eza, bat, fzf, zoxide, and yazi

---

## 10. Contact

Personal dotfiles configuration. Changes should be made carefully and tested.
