#!/bin/zsh
# Refreshes the tmux status bar once per second, sleeping each time only until
# the next whole-second boundary instead of a fixed interval, so the redraw
# stays anchored to the real clock rather than drifting.
zmodload zsh/datetime
while true; do
    sleep $(( 1 - EPOCHREALTIME % 1 ))
    tmux refresh-client -S 2>/dev/null || break
done
