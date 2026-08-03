# tmux config

Nord-themed tmux config with vi copy mode, true color, and keyboard layout switchers.

## Table of contents

- [Prefix key](#prefix-key)
- [Custom keybindings](#custom-keybindings)
- [Common tmux keybindings](#common-tmux-keybindings)
  - [Sessions](#sessions)
  - [Windows](#windows)
  - [Panes](#panes)
  - [Copy mode](#copy-mode)
- [Keyboard layout switchers](#keyboard-layout-switchers)

## Prefix key

The prefix key is `|` (pipe). Press it before any tmux command.

On a US keyboard where backtick is easy to reach, switch back with the [US layout switcher](#keyboard-layout-switchers).

## Custom keybindings

These bindings override or extend the tmux defaults.

| Key | Action |
|-----|--------|
| `prefix + r` | Reload tmux config |
| `prefix + \|` | Send prefix through to inner session |
| `prefix + +` | Split pane horizontally (new pane to the right) |
| `prefix + -` | Split pane vertically (new pane below) |
| `prefix + c` | New window in current directory |
| `prefix + h` | Move to pane left |
| `prefix + j` | Move to pane below |
| `prefix + k` | Move to pane above |
| `prefix + l` | Move to pane right |
| `prefix + C-h` | Resize pane left (5 cells, repeatable) |
| `prefix + C-j` | Resize pane down (5 cells, repeatable) |
| `prefix + C-k` | Resize pane up (5 cells, repeatable) |
| `prefix + C-l` | Resize pane right (5 cells, repeatable) |
| `prefix + v` | Enter copy mode |

**Copy mode (vi):**

| Key | Action |
|-----|--------|
| `v` | Begin selection |
| `y` | Copy selection and exit copy mode |

## Common tmux keybindings

These are standard tmux bindings, included here as a reference.

### Sessions

| Key | Action |
|-----|--------|
| `prefix + d` | Detach from session |
| `prefix + s` | List and switch sessions (tree view) |
| `prefix + $` | Rename current session |
| `prefix + (` | Switch to previous session |
| `prefix + )` | Switch to next session |
| `prefix + L` | Switch to last (most recently used) session |

### Windows

| Key | Action |
|-----|--------|
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + l` | Last (most recently used) window |
| `prefix + w` | List and switch windows (tree view) |
| `prefix + ,` | Rename current window |
| `prefix + &` | Kill current window (with confirmation) |
| `prefix + 0-9` | Switch to window by number |

### Panes

| Key | Action |
|-----|--------|
| `prefix + x` | Kill current pane (with confirmation) |
| `prefix + z` | Toggle pane zoom (fullscreen) |
| `prefix + q` | Show pane numbers (press number to jump) |
| `prefix + o` | Cycle to next pane |
| `prefix + {` | Swap pane with the one above |
| `prefix + }` | Swap pane with the one below |
| `prefix + Space` | Cycle through pane layouts |

### Copy mode

Enter with `prefix + v`. The config uses vi key bindings.

| Key | Action |
|-----|--------|
| `v` | Begin selection |
| `V` | Select entire line |
| `y` | Copy selection and exit |
| `q` / `Escape` | Exit copy mode |
| `h` / `j` / `k` / `l` | Move cursor |
| `w` / `b` | Next / previous word |
| `0` / `$` | Start / end of line |
| `g` / `G` | Top / bottom of history |
| `/` | Search forward |
| `?` | Search backward |
| `n` / `N` | Next / previous search match |
| `C-u` / `C-d` | Half page up / down |
| `C-b` / `C-f` | Full page up / down |

## Keyboard layout switchers

Two snippet files toggle the prefix key and horizontal split binding without restarting tmux.

**Switch to Latin America layout** (prefix = `|`, horizontal split = `+`):

```sh
tmux source-file ~/.config/tmux/tmux-la.conf
```

**Switch to US layout** (prefix = `` ` ``, horizontal split = `\`):

```sh
tmux source-file ~/.config/tmux/tmux-us.conf
```

A popup notification appears for 5 seconds after switching, confirming the new bindings.
