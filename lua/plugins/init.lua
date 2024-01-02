return {
	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',
	-- Useful plugin to show you pending keybinds.
	{
		'folke/which-key.nvim',
		init = function()
			require('which-key').register({
				['<leader>'] = { name = 'VISUAL <leader>' },
			}, { mode = { 'v', 'n' } })
		end
	},
	-- Auto close html tags
	"windwp/nvim-ts-autotag",
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
		-- Optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
