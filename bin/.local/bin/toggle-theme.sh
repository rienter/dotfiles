#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/theme-mode"
KITTY_THEME="~/.config/kitty/current-theme.conf"
KITTY_DARK="Neovim-Dark"
KITTY_LIGHT="Neovim-Light"

SWAY_THEME="/home/rie/.config/sway/themes/current"
SWAY_DARK="/home/rie/.config/sway/themes/dark"
SWAY_LIGHT="/home/rie/.config/sway/themes/light"

if [[ -f $STATE_FILE && $(cat $STATE_FILE) == "dark" ]]; then
	echo "light" >$STATE_FILE
	ln -sf 
	kitten themes --reload-in all $KITTY_LIGHT
	ln -sf $SWAY_LIGHT $SWAY_THEME
else
	echo "dark" >$STATE_FILE
	kitten themes --reload-in all $KITTY_DARK
	ln -sf $SWAY_DARK $SWAY_THEME
fi
for kitty_socket in ls /tmp/mykitty*; do
	kitty @ --to unix:"$kitty_socket" set-colors -a $KITTY_THEME
done
swaymsg reload
