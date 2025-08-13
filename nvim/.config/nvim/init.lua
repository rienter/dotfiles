require("config.lazy")
require("config.lsp")

vim.o.number = true
vim.o.relativenumber = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.mouse = ""

vim.o.winborder = 'rounded'

vim.opt.laststatus = 2
vim.opt.statusline = " %f %m %= %l:%c ♥ "
vim.opt.termguicolors = true

-- blinking block cursor
vim.o.guicursor = "a:block-blinkwait700-blinkoff400-blinkon250"

vim.o.cursorline = true

vim.cmd.colorscheme 'default'
