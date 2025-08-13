return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'main',
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = { 'c', 'lua', 'markdown', 'rust', 'python', 'bash', },
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		},
	},
}
