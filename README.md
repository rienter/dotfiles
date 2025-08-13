# Dotfiles

Dotfiles managed with `stow` for easy install on new machines.

## Dependencies

Here are the packages that I use in this configuration:

```
stow neovim tmux bash starship fzf ttf-input sway swaybg zoxide git rustup
lua-language-server clangd tree-sitter tree-sitter-cli ripgrep
```

I also use `tpm` to manage `tmux` plugins, and that needs to be installed to
use `tmux`:

```
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```
