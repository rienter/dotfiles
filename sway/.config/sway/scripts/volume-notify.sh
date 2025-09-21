#!/usr/bin/env bash

# Adjust volume: argument can be +0.05 / -0.05 (5%)
wpctl set-volume @DEFAULT_AUDIO_SINK@ "$1"

# Get current volume in percent
volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{printf "%d\n", $2*100}')

# Send notification with progress bar to Mako
makoctl dismiss -a
notify-send "Volume" "$volume%" -h int:value:"$volume" -h string:hlcolor:"#cba6f7" -h string:fgcolor:"#cdd6f4"
