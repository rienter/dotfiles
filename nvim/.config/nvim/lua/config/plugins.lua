-- Colorschemes
vim.pack.add({ "https://github.com/catppuccin/nvim" }, { name = "catppucin" })
require('catppuccin').setup {
  flavour = "mocha",
  transparent_background = true,
  custom_highlights = function(colors)
    return {
      StatusLine = { fg = colors.red, bg = colors.surface1, blend = 50, },
      StatusLineNC = { fg = colors.subtext0, bg = colors.base },
    }
  end,
}

vim.pack.add({ "https://github.com/rose-pine/neovim" }, { name = "rose-pine" })
require('rose-pine').setup {
  variant = "main",
  enable = {
    terminal = true,
    legacy_highlights = true,
  },
  styles = {
    transparency = true,
  },
  highlight_groups = {
    StatusLine = { fg = "love", bg = "love", blend = 10 },
    StatusLineNC = { fg = "subtle", bg = "surface" },
  },
}

vim.pack.add({ "https://github.com/vague2k/vague.nvim" })
require('vague').setup {
  transparent = true,
}

vim.cmd.colorscheme 'catppuccin'

-- Git
vim.pack.add({ "https://github.com/tpope/vim-fugitive" })

-- Highlight colors
vim.pack.add({ "https://github.com/brenoprata10/nvim-highlight-colors" })

-- Lazydev
vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
require('lazydev').setup {
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
  enabled = function(_)
    return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
  end,
}

-- Lualine
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require('lualine').setup {
  options = {
    theme = "catppuccin",
    section_separators = '',
    component_separators = '',
  },
}

-- Treesitter
vim.pack.add({{ src = "https://github.com/nvim-treesitter/nvim-treesitter",  version = "main" }})
require'nvim-treesitter'.setup {
  ensure_installed = { 'rust', 'go', 'lua', 'c'},
  sync_install = true,
  highlight = {
    enable = true,
  },
}
