#!/usr/bin/env bash

selected="$(find -L ~/.config ~/projects ~/.local/bin -maxdepth 1 -type d | fzf)"

if [ -z "$selected" ]; then
	exit
fi

name="$(basename $selected)"

if ! tmux has-session -t "$name" 2> /dev/null; then
	tmux new-session -d -s "$name" -c "$selected"
fi

if [ -z $TMUX ]; then
	tmux attach-session -t "$name"
else
	tmux switch-client -t "$name"
fi
