vim.o.number = true
vim.o.relativenumber = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.wrap = false
vim.o.scrolloff = 5

vim.opt.mouse = {}

vim.o.incsearch = true
vim.o.inccommand = 'split'
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.winborder = 'rounded'

vim.opt.laststatus = 2
-- vim.opt.statusline = " %f %m %= %l:%c ♥ "
vim.opt.termguicolors = true

-- blinking block cursor
vim.o.guicursor = "a:block-blinkwait700-blinkoff400-blinkon250"

vim.o.cursorline = true

-- cmdline completion
vim.api.nvim_create_autocmd('CmdlineChanged', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('CmdlineCompletion', { clear = true }),
  callback = function()
    vim.fn.wildtrigger()
  end,
})
vim.opt.wildmode = { "noselect:lastused", "full" }
vim.opt.wildoptions = { "pum" }

-- find command
vim.opt.path = { "*", ".", "", "**" }
