#!/bin/sh
# sxhkd is started by bspwmrc, from $HOME, with the bspwm config.
# Starting it here first blocks that launch and inherits startx's directory.
cd "$HOME" || exit 1
exec bspwm
