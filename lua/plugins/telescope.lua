return {
	{
		-- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VeryLazy',
		branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- Fuzzy Finder Algorithm which requires local dependencies to be built.
			-- Only load if `make` is available. Make sure you have the system
			-- requirements installed.
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			-- List common software licenses
			{ "chip/telescope-software-licenses.nvim" },
			-- List HTTP codes
			{ "barrett-ruth/telescope-http.nvim" },
			-- List Undo history tree
			{ "debugloop/telescope-undo.nvim" },
			-- Useful text case converter
			{ "johmsalas/text-case.nvim" },
			-- Use telescope for LSP code action popup
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
		config = function()
			require('telescope').setup({
				defaults = {
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-h>'] = "which_key",
						},
					},
				},
				pickers = {
					buffers = {
						theme = 'dropdown'
					},
					colorscheme = {
						enable_preview = true,
						mappings = {
							i = {
								['<CR>'] = function(bufnr)
									local actions = require("telescope.actions")
									local action_state = require("telescope.actions.state")
									local selection = action_state.get_selected_entry()
									local new = selection.value
									local file = io.open(vim.fn.stdpath('config') .. '/lua/colorscheme.lua', 'w')

									actions.close(bufnr)
									vim.cmd.colorscheme(new)
									if file then
										file:write('vim.cmd.colorscheme("' .. new .. '")')
										file:close()
									end
								end
							}
						},
					},
				}
			})
		end,
		init = function()
			local t = require('telescope')

			t.load_extension("software-licenses")
			t.load_extension("fzf")
			t.load_extension("http")
			t.load_extension("noice")
			t.load_extension("textcase")
			t.load_extension("undo")
			t.load_extension("ui-select")
		end
	},
}
