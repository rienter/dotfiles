#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH="$HOME/.local/share/bob/nvim-bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$PATH"
export EDITOR="nvim"
export VISUAL="kitty nvim"
. "/home/rie/.local/share/bob/env/env.sh"
