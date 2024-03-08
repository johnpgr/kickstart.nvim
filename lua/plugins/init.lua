return {
	'xiyaowong/transparent.nvim',
	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',
	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		init = function()
			require('which-key').setup({
				ignore_missing = true,
			})
		end
	},
	-- Surround Utils
	"tpope/vim-surround",
	-- Multi cursor
	"mg979/vim-visual-multi",
	-- LSP icons
	"onsails/lspkind.nvim",
	-- Lua functions
	{
		'nvim-lua/plenary.nvim',
		priority = 1000,
	},
	{
		-- Todo Comment highlights
		"folke/todo-comments.nvim",
		event = "BufRead",
	},
	{
		-- Nice Git UI
		"kdheepak/lazygit.nvim",
	},
	'vimpostor/vim-tpipeline'
}
