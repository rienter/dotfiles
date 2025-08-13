return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dashboard = { enabled = true, },
		explorer = { enabled = true, },
		picker = { enabled = true, },
	},
	keys = {
		-- Pickers
		{ "<space>ff", function() Snacks.picker.files() end, desc = "Find Files" },
		{ "<space>ex", function() Snacks.explorer() end, desc = "EXplorer" },
		{ "<space>gr", function() Snacks.picker.grep() end, desc = "GRep files" },
		-- Git
		{ "<space>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
	},
}
