#!/bin/bash
set -euo pipefail

# Reload `tmux.conf` while preserving the active keyboard layout
# (`tmux.conf` resets @keyboard_layout to its default on every source).
layout=$(tmux show-options -gv @keyboard_layout)

tmux source-file ~/.config/tmux/tmux.conf

tmux display-popup -w 35 -h 4 "printf 'tmux config reloaded\nPress escape to exit'"

if [ "$layout" = "us" ]; then
    tmux set-option -g @kb_silent 1
    trap 'tmux set-option -gu @kb_silent' EXIT
    tmux source-file ~/.config/tmux/tmux-us.conf
fi
