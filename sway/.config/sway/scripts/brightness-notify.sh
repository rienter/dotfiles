#!/usr/bin/env bash
# Adjust brightness based on argument (+10% / -10% / absolute)
brightnessctl set "$1"

# Get current brightness percentage
current=$(brightnessctl get)
max=$(brightnessctl max)
percent=$((current*100/max))

# Send notification
makoctl dismiss -a
notify-send --replace-id=BRIGHTNESS "Brightness" "$percent%" -h int:value:$percent -h string:hlcolor:"#fab387" -h string:fgcolor:"#cdd6f4"
