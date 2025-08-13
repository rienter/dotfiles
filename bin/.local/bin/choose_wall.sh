#!/usr/bin/env bash

wall="$(find ~/.config/wallpapers/ -type f | rofi -dmenu)"
pkill swaybg
swaybg -i "$wall" -m fill &
