# AGENTS.md - Neovim Configuration Guidelines

This is a LazyVim-based Neovim configuration. Agents working on this codebase should follow these guidelines.

## Project Overview

- **Framework**: LazyVim (Neovim distribution)
- **Language**: Lua (Neovim plugin development)
- **Plugin Manager**: lazy.nvim

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
│       └── *.lua            # Other plugin configurations
├── stylua.toml             # Lua formatter config
└── lazy-lock.json          # Locked plugin versions
```

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
