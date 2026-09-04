# Neovim config

Neovim config using [`vim.pack`](https://neovim.io/doc/user/pack.html), Neovim's built-in plugin manager.

## Table of contents

- [Plugin manager](#plugin-manager)
  - [Troubleshooting](#troubleshooting)
- [Plugins](#plugins)
  - [Completion: blink.cmp + LuaSnip](#completion-blinkcmp--luasnip)
  - [LSP: nvim-lspconfig + Mason](#lsp-nvim-lspconfig--mason)
  - [Formatting: conform.nvim](#formatting-conformnvim)
  - [Syntax: nvim-treesitter](#syntax-nvim-treesitter)
  - [Fuzzy finder: Telescope](#fuzzy-finder-telescope)
  - [File tree: nvim-tree](#file-tree-nvim-tree)
  - [Git signs: gitsigns.nvim](#git-signs-gitsignsnvim)
  - [Git conflicts: git-conflict.nvim](#git-conflicts-git-conflictnvim)
  - [Git diffs: diffview.nvim](#git-diffs-diffviewnvim)
  - [Buffers: barbar.nvim](#buffers-barbarnvim)
  - [Markdown: markview.nvim](#markdown-markviewnvim)
  - [Comments: ts-comments.nvim](#comments-ts-commentsnvim)
  - [Autopairs: nvim-autopairs](#autopairs-nvim-autopairs)
  - [Indentation: indent-blankline.nvim](#indentation-indent-blanklinenvim)
  - [Clipboard: nvim-osc52](#clipboard-nvim-osc52)
  - [Keybind hints: which-key.nvim](#keybind-hints-which-keynvim)
  - [Theme: nord.nvim](#theme-nordnvim)
  - [Cursor position: remember.nvim](#cursor-position-remembernvim)
  - [Indent detection: guess-indent.nvim](#indent-detection-guess-indentnvim)

## Plugin manager

**`vim.pack`** is built into Neovim (0.12+), so no bootstrap step is needed. Each plugin is installed and configured in its own file under `lua/plugins/`, required in dependency order from `lua/plugins/init.lua`. Shared build steps (e.g. `telescope-fzf-native`'s `make`, `LuaSnip`'s `make install_jsregexp`, `nvim-treesitter`'s `:TSUpdate`) run via a `PackChanged` autocmd defined in `lua/pack.lua`.

Useful commands:

| Command                                       | Action                             |
| --------------------------------------------- | ---------------------------------- |
| `:lua = vim.pack.get()`                       | List installed plugins             |
| `:lua vim.pack.update()`                      | Update all plugins                 |
| `:lua vim.pack.update(nil, { force = true })` | Force-reinstall/update all plugins |
| `:checkhealth vim.pack`                       | Run plugin manager health checks   |

### Troubleshooting

If a plugin install is interrupted (e.g. the terminal closes mid-clone), its directory under `~/.local/share/nvim/site/pack/core/opt/` can be left incomplete. Neovim then fails on startup with an error like `module 'barbar' not found`.

`vim.pack.update()` does not fix this, since the plugin directory already exists and is not re-cloned.

| Command                                | Action                       |
| --------------------------------------- | ---------------------------- |
| `rm -rf ~/.local/share/nvim/site/pack` | Remove all installed plugins |

Reopen Neovim afterward and wait for the install progress to reach 100% before doing anything else.

## Plugins

### Completion: blink.cmp + LuaSnip

[blink.cmp](https://github.com/saghen/blink.cmp) handles autocompletion. [LuaSnip](https://github.com/L3MON4D3/LuaSnip) provides snippet expansion.

Sources: LSP, path, and snippets.

| Key                 | Action                                 |
| ------------------- | -------------------------------------- |
| `<Tab>` / `<S-Tab>` | Select next / previous completion item |
| `<C-space>`         | Open completion menu or docs           |
| `<C-n>` / `<C-p>`   | Select next / previous item            |
| `<C-e>`             | Close completion menu                  |
| `<C-k>`             | Toggle signature help                  |

### LSP: nvim-lspconfig + Mason

[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) configures language servers. [Mason](https://github.com/williamboman/mason.nvim) auto-installs them.

Servers installed automatically: `lua_ls` (Lua), `stylua` (formatter).

Optional servers (uncomment in `lua/plugins/lspconfig.lua` to enable): `pyright`, `ruff`.

**LSP keymaps** (active when an LSP attaches to a buffer):

| Key          | Action                                 |
| ------------ | -------------------------------------- |
| `grd`        | Go to definition                       |
| `grD`        | Go to declaration                      |
| `grr`        | Go to references                       |
| `gri`        | Go to implementation                   |
| `grt`        | Go to type definition                  |
| `gO`         | Open document symbols                  |
| `gW`         | Open workspace symbols                 |
| `grn`        | Rename symbol                          |
| `gra`        | Code action / suggestions              |
| `<leader>th` | Toggle inline type and parameter hints |

**Diagnostic keymaps:**

| Key         | Action                           |
| ----------- | -------------------------------- |
| `]d`        | Next diagnostic                  |
| `[d`        | Previous diagnostic              |
| `<leader>e` | Open floating diagnostic message |
| `<leader>d` | Open diagnostic quickfix list    |

### Formatting: conform.nvim

[conform.nvim](https://github.com/stevearc/conform.nvim) runs formatters on demand.

Configured formatters: `stylua` for Lua, `ruff_format` and `ruff_organize_imports` for Python.

| Key         | Action                |
| ----------- | --------------------- |
| `<leader>f` | Format current buffer |

### Syntax: nvim-treesitter

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) provides syntax highlighting and indentation.

Auto-installs parsers for: `bash`, `c`, `diff`, `html`, `lua`, `markdown`, `vim`, `vimdoc`, and others on demand.

No custom keymaps.

### Fuzzy finder: Telescope

[telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fuzzy finding files, text, buffers, and more.

| Key                | Action                         |
| ------------------ | ------------------------------ |
| `<leader>sf`       | Find files                     |
| `<leader>sr`       | Recent files                   |
| `<leader>sb`       | Open buffers                   |
| `<leader>sw`       | Search word under cursor       |
| `<leader><leader>` | Live grep in current directory |
| `<leader>so`       | Live grep in open files        |
| `<leader>sh`       | Search help tags               |
| `<leader>sk`       | Search keymaps                 |
| `<leader>st`       | Search Telescope pickers       |
| `<leader>sn`       | Search Neovim config files     |
| `<leader>/`        | Fuzzy search in current buffer |

Inside a Telescope picker: press `<C-/>` (insert mode) or `?` (normal mode) to see all available keymaps.

### File tree: nvim-tree

[nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) is a sidebar file explorer with git status indicators.

Shows dotfiles. Follows the current file automatically.

| Key     | Action           |
| ------- | ---------------- |
| `<C-n>` | Toggle file tree |

### Git signs: gitsigns.nvim

[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) shows git change markers in the line-number margin and provides hunk-level staging and diffing.

**Navigation:**

| Key  | Action              |
| ---- | ------------------- |
| `]c` | Next git change     |
| `[c` | Previous git change |

**Hunk actions:**

| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>hs` | Stage hunk               |
| `<leader>hr` | Reset hunk               |
| `<leader>hS` | Stage entire buffer      |
| `<leader>hR` | Reset entire buffer      |
| `<leader>hp` | Preview hunk popup       |
| `<leader>hi` | Preview hunk inline      |
| `<leader>hb` | Blame current line       |
| `<leader>hd` | Diff against index       |
| `<leader>hD` | Diff against last commit |

**Toggles:**

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>tb` | Toggle line blame |
| `<leader>tw` | Toggle word diff  |

**Text object:**

| Key  | Action                               |
| ---- | ------------------------------------ |
| `ih` | Select hunk (operator / visual mode) |

### Git conflicts: git-conflict.nvim

[git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim) highlights merge conflict markers using Nord colors.

No custom keymaps. Default bindings: `co` (ours), `ct` (theirs), `cb` (both), `c0` (none), `]x` / `[x` (next / previous conflict).

### Git diffs: diffview.nvim

[diffview.nvim](https://github.com/sindrets/diffview.nvim) provides a rich diff and file history viewer.

| Command                  | Action                   |
| ------------------------ | ------------------------ |
| `:DiffviewOpen`          | Open diff against index  |
| `:DiffviewFileHistory %` | History for current file |
| `:DiffviewClose`         | Close diffview           |

### Buffers: barbar.nvim

[barbar.nvim](https://github.com/romgrk/barbar.nvim) shows open buffers as a tab bar at the top of the screen.

| Key         | Action               |
| ----------- | -------------------- |
| `<leader>n` | Next buffer          |
| `<leader>p` | Previous buffer      |
| `<leader>q` | Close current buffer |

### Markdown: markview.nvim

[markview.nvim](https://github.com/OXY2DEV/markview.nvim) renders Markdown inline in the buffer (headings, tables, code blocks).

No custom keymaps. Toggle with `:Markview` or `:Markview toggle`.

### Comments: ts-comments.nvim

[ts-comments.nvim](https://github.com/folke/ts-comments.nvim) enhances Neovim's built-in comment operator with Treesitter-aware comment strings per language.

| Key   | Action                                    |
| ----- | ----------------------------------------- |
| `gcc` | Toggle line comment                       |
| `gc`  | Toggle comment (works with movement keys) |

### Autopairs: nvim-autopairs

[nvim-autopairs](https://github.com/windwp/nvim-autopairs) automatically closes brackets, quotes, and parens as you type.

No custom keymaps.

### Indentation: indent-blankline.nvim

[indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) draws a thin guide line (`▏`) at each indent level.

No custom keymaps.

### Clipboard: nvim-osc52

[nvim-osc52](https://github.com/ojroques/nvim-osc52) copies yanked text to the system clipboard over SSH via OSC 52 (a terminal escape sequence that tells the terminal to write to the clipboard). Works without a local clipboard tool on remote machines.

Activates automatically on any yank or delete to the unnamed register (the default yank destination in Vim). No keymaps needed.

### Keybind hints: which-key.nvim

[which-key.nvim](https://github.com/folke/which-key.nvim) shows a popup listing available keybindings after you pause mid-sequence.

Opens automatically after a short delay (configured to `0 ms`). Press any key to dismiss.

### Theme: nord.nvim

[nord.nvim](https://github.com/shaunsingh/nord.nvim) applies the Nord color palette. Configured with italics disabled and a transparent background so the terminal background shows through.

### Cursor position: remember.nvim

[remember.nvim](https://github.com/vladdoster/remember.nvim) restores the cursor to its last position when reopening a file.

No keymaps.

### Indent detection: guess-indent.nvim

[guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) detects `tabstop` and `shiftwidth` automatically from the file content and surrounding files.

No keymaps.
