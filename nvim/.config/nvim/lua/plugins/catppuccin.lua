return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		transparent_background = true,
		custom_highlights = function(colors)
			return {
				StatusLine = { fg = colors.red, bg = colors.surface1, blend = 50, },
				StatusLineNC = { fg = colors.subtext0, bg = colors.base },
			}
		end,
	},
}
