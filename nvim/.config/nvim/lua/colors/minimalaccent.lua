vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "minimalaccent"

local base    = "#cccac2"
local string  = "#f28779"
local comment = "#686868"

-- Uniform highlight groups
local uniform_groups = {
  "Normal", "Keyword", "Function", "Identifier", "Type",
  "Statement", "Conditional", "Repeat", "Operator", "Number",
  "Constant", "PreProc", "Special", "Boolean", "Float",
}

for _, group in ipairs(uniform_groups) do
  vim.api.nvim_set_hl(0, group, { fg = base })
end

-- Accent only strings and comments
vim.api.nvim_set_hl(0, "String", { fg = string })
vim.api.nvim_set_hl(0, "Comment", { fg = comment, italic = true })

-- Optional: Transparent background
vim.api.nvim_set_hl(0, "Normal", { fg = base, bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { fg = base, bg = "NONE" })

