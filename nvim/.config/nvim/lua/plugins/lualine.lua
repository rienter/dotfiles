vim.opt.showmode = false

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = "horizon",
      section_separators = '',
      component_separators = '',
    },
  }
}
