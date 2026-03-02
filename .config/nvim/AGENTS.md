# AGENTS.md - Neovim Configuration Guidelines

This is a LazyVim-based Neovim configuration. Agents working on this codebase should follow these guidelines.

## Project Overview

- **Framework**: LazyVim (Neovim distribution)
- **Language**: Lua (Neovim plugin development)
- **Plugin Manager**: lazy.nvim
- **Repository**: Git (own repo separate from home dotfiles)

## Directory Structure

```
nvim/
├── init.lua                 # Entry point - bootstraps lazy.nvim
├── lua/
│   ├── config/              # User configuration (lazy, options, keymaps, autocmds)
│   │   ├── lazy.lua         # Plugin manager setup
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Keybindings
│   │   └── autocmds.lua     # Autocommands
│   └── plugins/             # Plugin specifications
│       ├── colorscheme.lua  # Theme configuration
│       ├── dashboard.lua    # Snacks dashboard + picker + explorer
│       ├── terminal.lua     # Terminal configuration
│       └── smear_cursor.lua # Cursor effects
├── stylua.toml             # Lua formatter config
├── lazy-lock.json          # Locked plugin versions
└── .gitignore             # Git ignore (excludes lazy-lock.json)
```

## Recent Changes (2026-03-01)

### Git Repository Setup
- Created separate git repository for `~/.config/nvim/` (independent from home dotfiles)
- Purpose: Better isolation, portability, and clean git history

### Snacks Picker Configuration
- Enabled `picker` and `explorer` modules in snacks.nvim
- Git status is accessed via `<leader>gs` (picker view, not tree indicators)
- Note: snacks.explorer does not show git status in tree view (use picker for git status)

### Git Keymaps Added
- `<leader>gc` - Git commit (with vim.ui.input for message)
- `<leader>ga` - Git add all (with notification)
- `<leader>gp` - Git push (requires remote configured)

### Code Refactoring (2026-03-01)
Applied DRY principles to lua configuration files:

- **terminal.lua**: Added `event = "VeryLazy"` for lazy loading, moved require inside keymap functions
- **keymaps.lua**: Added `run_git_cmd()` helper to eliminate duplicated git command logic
- **dashboard.lua**: Extracted header to `HOLO_NIGHT_HEADER` constant for better readability

All keymaps preserved - no breaking changes.

## Build/Lint/Test Commands

### Running Neovim
```bash
nvim          # Start Neovim
nvim +Lazy    # Start and sync plugins
```

### Lua Formatting
```bash
stylua .      # Format all Lua files
stylua lua/   # Format specific directory
stylua --check lua/  # Check formatting without modifying
```

### Lua Linting
```bash
luacheck lua/           # Lint Lua files
selene lua/             # Alternative Lua linter
```

### Plugin Management
```bash
:Lazy sync              # Sync plugins (install/update/remove)
:Lazy check             # Check for plugin updates
:Lazy clean             # Remove unused plugins
:Lazy profile           # Profile plugin load times
```

### Testing Changes
- Restart Neovim to test changes
- Use `:Lazy` command to manage plugins
- Check `:checkhealth` for issues

## Code Style Guidelines

### General Principles
- Follow LazyVim conventions from [LazyVim](https://github.com/LazyVim/LazyVim)
- Keep configurations minimal - only override what's needed
- Use descriptive comments for non-obvious configurations

### Lua Style

#### Formatting (per stylua.toml)
- **Indent**: 2 spaces (no tabs)
- **Column width**: 120
- **Indent type**: Spaces

#### Example:
```lua
return {
  {
    "plugin/name",
    opts = {
      option = value,
      nested = {
        key = "value",
      },
    },
    config = function()
      -- Code here
    end,
  },
}
```

### Plugin Specifications

#### Structure
```lua
return {
  {
    "author/plugin-name",           -- GitHub repo or local plugin
    -- Optional keys:
    event = "VeryLazy",              -- Lazy-load on event
    cmd = "CommandName",             -- Lazy-load on command
    keys = { "<leader>ff", ... },    -- Lazy-load on keymap
    priority = 1000,                 -- Load priority
    opts = { ... },                  -- Plugin options
    config = function() ... end,     -- Configuration function
    dependencies = { ... },          -- Plugin dependencies
  },
}
```

#### Common Patterns
```lua
-- Basic plugin
{ "nvim-tree/nvim-tree.lua" }

-- With options
{ "nvim-tree/nvim-tree.lua", opts = { ... } }

-- With dependencies
{ "nvim-tree/nvim-tree.lua", dependencies = { "nvim-lua/plenary.nvim" } }

-- Conditional loading
{ "neovim/nvim-lspconfig", cond = vim.fn.has("nvim-0.10") == 1 }
```

### Keymaps

#### Format
```lua
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>write<cr>", { desc = "Save file" })
```

- Use `vim.keymap.set` (not `vim.api.nvim_set_keymap`)
- Modes: `n` (normal), `i` (insert), `v` (visual), `x` (visual select)
- Always include `desc` for documentation

### Autocmds

#### Format
```lua
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "*.lua",
  callback = function(args)
    -- Code here
  end,
  desc = "Description of autocmd",
})
```

### Options

#### Format
```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
```

### Imports

- Use `require("module")` for loading modules
- Use relative paths from `lua/` directory
- Example: `require("config.keymaps")`

### Error Handling

```lua
-- Safe plugin loading
pcall(require, "plugin-name")  -- Graceful fallback

-- System command with error handling
local handle = vim.fn.jobstart({ "command" }, {
  on_exit = function(_, code)
    if code ~= 0 then
      vim.notify("Command failed", vim.log.levels.ERROR)
    end
  end,
})
```

### Naming Conventions

- **Files**: snake_case.lua (e.g., `lazy.lua`, `keymaps.lua`)
- **Variables**: snake_case (e.g., `local lazypath = ...`)
- **Plugin specs**: Use GitHub `owner/repo` format
- **Keymap leaders**: Use `<leader>` prefix for user keymaps
- **Buffer names**: Use descriptive names (e.g., `BufEnter`, `FileType`)

### Testing Plugin Changes

1. Restart Neovim or use `:qa` then reopen
2. Run `:Lazy sync` after modifying plugin specs
3. Check `:lua vim.print(vim.opt)` to inspect options
4. Use `:messages` to see runtime errors

### Common Commands

```vim
:Lazy sync          " Install/update plugins
:Lazy clean         " Remove unused plugins
:Lazy check         " Check for updates
:Lazy profile       " View load performance
:Lazy log           " View lazy.nvim logs
:checkhealth        " Check Neovim health
```

## References

- [LazyVim Documentation](https://lazyvim.org)
- [Neovim Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [stylua](https://github.com/JohnnyMorganz/StyLua)
- [luacheck](https://github.com/mpeterv/luacheck)

## Installed Plugins

### Core (LazyVim Base)

| Plugin | Description | Function |
|--------|-------------|----------|
| LazyVim/LazyVim | Base distribution | Core framework |
| folke/lazy.nvim | Plugin manager | Lazy loading and management |
| folke/snacks.nvim | QoL utilities | Dashboard, picker, explorer, terminal |
| folke/tokyonight.nvim | Colorscheme | Theme (tokyonight night) |

### Editor Enhancement

| Plugin | Description | Function |
|--------|-------------|----------|
| smol-ai/blink.cmp | Completion | AI-powered completion |
| nvim-lspconfig | LSP | Language Server Protocol |
| neovim/nvim-lint | Linting | Inline linting |
| stevearc/conform.nvim | Formatting | Code formatting |
| nvim-treesitter/nvim-treesitter | Syntax | Syntax highlighting |
| nvim-treesitter-textobjects | Treesitter textobjects | textobject selection |
| windwp/nvim-ts-autotag | Autotag | Auto close/rename HTML tags |

### UI Components

| Plugin | Description | Function |
|--------|-------------|----------|
| akinsho/bufferline.nvim | Bufferline | Tab bar for buffers |
| nvim-lualine/lualine.nvim | Statusline | Bottom status line |
| folke/noice.nvim | UI | Better messages, cmdline, popups |
| folke/trouble.nvim | Diagnostics | Diagnostics list view |
| folke/which-key.nvim | Which-key | Keybinding hints popup |

### Git Integration

| Plugin | Description | Function |
|--------|-------------|----------|
| lewis6991/gitsigns.nvim | Git signs | Git decorations in gutter |
| kkosmo/grug-far.nvim | Git search | Grep replace in git |

### Tools

| Plugin | Description | Function |
|--------|-------------|----------|
| folke/todo-comments.nvim | Todo comments | Highlight TODO/FIX in code |
| folke/persistence.nvim | Persistence | Session preservation |
| jose-elias-alvarez/venv-selector.nvim | Venv selector | Python virtual env selector |
| jesseduffield/lazygit.nvim | LazyGit | Git integration |

### Terminal

| Plugin | Description | Function |
|--------|-------------|----------|
| akinsho/toggleterm.nvim | Toggle terminal | Floating terminals |

### Cursor Effects

| Plugin | Description | Function |
|--------|-------------|----------|
| aszoke/smear-cursor.nvim | Smear cursor | Cursor trail effect |

### Mini Plugins (LazyVim)

| Plugin | Description | Function |
|--------|-------------|----------|
| echasnovski/mini.ai | textobjects | Better textobjects |
| echasnovski/mini.pairs | Auto pairs | Auto closing brackets |
| echasnovski/mini.icons | Icons | File type icons |

### Snippets

| Plugin | Description | Function |
|--------|-------------|----------|
| rafamadriz/friendly-snippets | Snippets | Code snippets |

### Development Tools

| Plugin | Description | Function |
|--------|-------------|----------|
| williamboman/mason.nvim | Mason | LSP/DAP installer |
| williamboman/mason-lspconfig.nvim | Mason LSPConfig | LSP configuration |
| folke/lazydev.nvim | LazyDev | Lua development |
| b0o/SchemaStore.nvim | Schema Store | JSON schema validation |

## Keymaps Summary

### File Operations

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>e` | Snacks.explorer() | File Explorer |
| `<leader><space>` | Snacks.picker.smart() | Smart Find Files |
| `<leader>ff` | Snacks.picker.files() | Find Files |
| `<leader>fb` | Snacks.picker.buffers() | Buffers |
| `<leader>fc` | Snacks.picker.files(cwd=config) | Find Config File |
| `<leader>fr` | Snacks.picker.recent() | Recent Files |

### Git Operations

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>gs` | Snacks.picker.git_status() | Git Status |
| `<leader>gd` | Snacks.picker.git_diff() | Git Diff (hunks) |
| `<leader>gD` | Snacks.picker.git_diff(origin) | Git Diff (origin) |
| `<leader>gl` | Snacks.picker.git_log() | Git Log |
| `<leader>gS` | Snacks.picker.git_stash() | Git Stash |
| `<leader>gc` | vim.ui.input + git commit | Git Commit (with message) |
| `<leader>ga` | git add -A | Git Add all (with notification) |
| `<leader>gp` | git push | Git Push (requires remote) |
| `<leader>oo` | ToggleTerm | Open Terminal |
| `<leader>ot` | ToggleTerm | Open Terminal (toggle) |

### Search & Picker

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>/` | Snacks.picker.search() | Search |
| `<leader>sg` | Snacks.picker.grep() | Grep |
| `<leader>sw` | Snacks.picker.words() | Workspace words |
| `<leader>sd` | Snacks.picker.diagnostics() | Diagnostics |
| `<leader>sh` | Snacks.picker.help() | Help |

### LSP

| Keymap | Command | Description |
|--------|---------|-------------|
| `gd` | Snacks.picker.lsp_definitions() | Goto Definition |
| `gr` | Snacks.picker.lsp_references() | References |
| `gI` | Snacks.picker.lsp_implementations() | Goto Implementation |
| `gy` | Snacks.picker.lsp_type_definitions() | Goto Type Definition |
| `<leader>ss` | Snacks.picker.lsp_symbols() | LSP Symbols |
| `<leader>sS` | Snacks.picker.lsp_workspace_symbols() | Workspace Symbols |

### Window & Layout

| Keymap | Command | Description |
|--------|---------|-------------|
| `<C-d>` | Scroll down | Scroll down |
| `<C-u>` | Scroll up | Scroll up |
| `<C-w>` | Window navigation | Standard vim navigation |

### Misc

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>uC` | Snacks.picker.colorschemes() | Colorschemes |
| `<leader>u` | Undotree | Undo tree |
| `<leader>st` | Snacks.picker.todo_comments() | Todo comments |
| `<leader>sT` | Snacks.picker.todo_comments(TODO/FIX) | Todo/Fix |
| `<leader>x` | Trouble | Toggle Trouble |
| `<leader>cs` | Conform | Format |
