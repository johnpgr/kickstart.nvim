return {
	{
		-- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VeryLazy',
		branch = '0.1.x',
		dependencies = {
			'plenary',
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
			{ "chip/telescope-software-licenses.nvim" },
			{ "barrett-ruth/telescope-http.nvim" }
		},
		config = function()
			require('telescope').setup({
				defaults = {
					mappings = {
						i = {
							['<C-u>'] = false,
							['<C-d>'] = require("telescope.actions").delete_buffer,
							['<C-h>'] = "which_key",
						},
						n = {
							['C-d'] = require("telescope.actions").delete_buffer
						}
					},
				},
				pickers = {
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
						}
					},
				}
			})
		end,
		init = function()
			require("telescope").load_extension("software-licenses")
			require('telescope').load_extension("fzf")
			require("telescope").load_extension("http")
			require("telescope").load_extension("noice")
			require("telescope").load_extension("textcase")
		end
	},
	{
		"johmsalas/text-case.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		priority = 1000,
	},

}
