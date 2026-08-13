# dotfiles

Personal dotfiles managed as a Git repository and symlinked into `$HOME`.

## Table of contents

- [What's included](#whats-included)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Shell config](#shell-config)
- [Machine-local overrides](#machine-local-overrides)

## What's included

| Path                 | Purpose                                                               |
| -------------------- | --------------------------------------------------------------------- |
| `.zshrc`             | Zsh config: history, aliases, prompt, vi-mode, Antigen plugin manager |
| `.gitconfig`         | Git config: delta pager, histogram diffs, Nord color scheme           |
| `.dir_colors`        | Nord-themed `ls` colors                                               |
| `.config/nvim/`      | Neovim config ([Neovim README](.config/nvim/README.md))               |
| `.config/tmux/`      | tmux config ([tmux README](.config/tmux/README.md))                   |
| `.config/alacritty/` | Alacritty terminal: Nord theme, JetBrainsMono Nerd Font               |
| `.config/wezterm/`   | WezTerm terminal: Nord theme, JetBrainsMono Nerd Font                 |

## Prerequisites

Required:

| Tool           | Required by                             | Install                  |
| -------------- | --------------------------------------- | ------------------------ |
| `git`          | everything                              | system package manager   |
| `curl`         | `.zshrc` downloads Antigen on first run | system package manager   |
| `nvim` >= 0.10 | `.config/nvim/`                         | `brew install neovim`    |
| `tmux`         | `.config/tmux/`                         | `brew install tmux`      |
| `delta`        | `.gitconfig`                            | `brew install git-delta` |
| `rg` (ripgrep) | `.zshrc` alias, Neovim Telescope        | `brew install ripgrep`   |

macOS - optional but recommended:

| Tool                    | Purpose                                       | Install                                      |
| ----------------------- | --------------------------------------------- | -------------------------------------------- |
| GNU coreutils           | Better `ls` colors via `gls` and `gdircolors` | `brew install coreutils`                     |
| Alacritty               | GPU-accelerated terminal                      | https://alacritty.org                        |
| JetBrainsMono Nerd Font | Required by the Alacritty config              | `brew install font-jetbrains-mono-nerd-font` |

Auto-installed on first use:

| Tool               | What installs it                                     |
| ------------------ | ---------------------------------------------------- |
| Antigen            | `.zshrc` downloads it via `curl` on first shell load |
| lazy.nvim          | Neovim installs it on first launch                   |
| `lua_ls`, `stylua` | Mason installs them on first Neovim launch           |

## Setup

### 1. Clone

```sh
git clone <your-repo-url> ~/dotfiles
```

### 2. Symlink shell and git config

```sh
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.dir_colors ~/.dir_colors
```

### 3. Symlink Neovim and tmux configs

```sh
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
ln -s ~/dotfiles/.config/tmux ~/.config/tmux
```

### 4. Symlink terminal emulator configs (optional)

```sh
ln -s ~/dotfiles/.config/alacritty ~/.config/alacritty
ln -s ~/dotfiles/.config/wezterm ~/.config/wezterm
```

### 5. Set up machine-specific git identity

Create `~/.gitconfig.local` (untracked, never committed):

```gitconfig
[user]
    name  = Your Name
    email = your@email.com
```

### 6. Apply the shell config

```sh
source ~/.zshrc
```

Antigen downloads and installs Zsh plugins on this first run.

### 7. Open Neovim

```sh
nvim
```

lazy.nvim installs itself and all plugins on first launch.

## Shell config

**`.dir_colors`** provides Nord-themed colors for `ls`. Sourced automatically by `.zshrc` at startup via `dircolors` (or `gdircolors` on macOS with GNU coreutils installed).

**Antigen** is the Zsh plugin manager. `.zshrc` downloads `antigen.zsh` to `$HOME` via `curl` on the first run if it is not already present.

| Plugin                                   | Purpose                                 |
| ---------------------------------------- | --------------------------------------- |
| `zsh-users/zsh-autosuggestions`          | Fish-style inline command suggestions   |
| `jeffreytse/zsh-vi-mode`                 | Vi key bindings in the shell            |
| `zsh-users/zsh-syntax-highlighting`      | Real-time syntax coloring               |
| `zsh-users/zsh-history-substring-search` | Up/down arrows search history by prefix |

## Machine-local overrides

| File                 | Purpose                                                |
| -------------------- | ------------------------------------------------------ |
| `~/.gitconfig.local` | Git identity (name, email), work-specific git settings |
| `~/.zshrc.local`     | Machine-specific aliases, exports, or overrides        |

Neither file is tracked. `.gitconfig` includes `.gitconfig.local` automatically (silently ignored if absent). `.zshrc` sources `.zshrc.local` at the end if it exists.
