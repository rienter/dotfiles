#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias vim='nvim'
PS1='[\u@\h \W]\$ '

# Starhip
eval "$(starship init bash)"

# Zoxide
eval "$(zoxide init bash)"

# Fzf
eval "$(fzf --bash)"
