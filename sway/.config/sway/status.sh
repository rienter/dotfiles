#!/usr/bin/env bash

echo '{"version":1}'
echo '['
echo '[],'

while true; do
    layout=$(swaymsg -t get_inputs | jq -r '.[] | select(.type=="keyboard") | .xkb_active_layout_name' | head -n 1)
    wifi=$(nmcli -t -f active,ssid,signal dev wifi | grep '^yes' | awk -F: '{print $2 " (" $3 "%)"}')
    [ -z "$wifi" ] && wifi="No Wi-Fi"

    volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d%%", $2*100}')
    mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo " (muted)" || echo "")

    brightness=$(brightnessctl -m | cut -d, -f4)

    battery=$(cat /sys/class/power_supply/BAT*/capacity)
    status=$(cat /sys/class/power_supply/BAT*/status)
    battery_text="$battery% ($status)"

    time=$(date '+%Y-%m-%d %H:%M')

    echo "["
	echo "{\"name\":\"layout\",\"full_text\":\" $layout\"},"
    echo "{\"name\":\"wifi\",\"full_text\":\" $wifi\"},"
    echo "{\"name\":\"volume\",\"full_text\":\" $volume$mute\"},"
    echo "{\"name\":\"brightness\",\"full_text\":\"☀ $brightness\"},"
    echo "{\"name\":\"battery\",\"full_text\":\" $battery_text\"},"
    echo "{\"name\":\"time\",\"full_text\":\" $time\"}"
    echo "],"
    sleep 1
done
