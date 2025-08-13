-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	lazy = true,
	name = "rose-pine",
	opts = {
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
	},
}
