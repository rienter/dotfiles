#!/usr/bin/env bash

# Install tpm for tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

pkg_list="sway swaybg mako waybar wofi kitty tmux zoxide fzf ripgrep"

# Get the correct package manager command based on the linux distribution
case "$(uname -a | cut -d" " -f2 | tr '[:upper:]' '[:lower:]')" in
	"fedora") pkg_mngr="dnf install" ;;
	"ubuntu") pkg_mngr="apt get" ;;
	"debian") pkg_mngr="apt get" ;;
	"arch") pkg_mngr="pacman -S" ;;
	*) pkg_mngr="" ;;
esac

# Install packages if a package manager was recognized
if [ -n "$pkg_mngr" ]; then
	eval ("$pkg_manager $pkg_list")
fi
