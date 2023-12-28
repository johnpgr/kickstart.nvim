local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- NOTE: First, some plugins that don't require any configuration
	{
		-- Theme inspired by Atom
		'navarasu/onedark.nvim',
		priority = 1000,
		-- config = function()
		--     vim.cmd("colorscheme onedark")
		-- end
	},
	{
		"blazkowolf/gruber-darker.nvim",
		opts = {
			italic = {
				strings = false,
				comments = false,
				operators = false,
				folds = false,
			}
		}
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require('gruvbox').setup({
				italic = {
					folds = false,
					strings = false,
					comments = false,
					emphasis = false,
					operators = false
				},
				-- contrast = "hard"
				transparent_mode = true
			})
		end
	},

	-- Git related plugins
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',

	-- Detect tabstop and shiftwidth automatically
	'tpope/vim-sleuth',

	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},

	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
		config = function()
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			require('luasnip.loaders.from_vscode').lazy_load()
			luasnip.config.setup {}
			local lspkind = require('lspkind')

			cmp.setup {
				formatting = {
					fields = {
						'kind',
						'abbr',
						'menu'
					},
					format = lspkind.cmp_format({
						preset = 'codicons',
						mode = 'symbol', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					})
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete {},
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				},
			}
		end
	},

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',  opts = {} },
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = 'Preview git hunk' })

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({ 'n', 'v' }, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
				vim.keymap.set({ 'n', 'v' }, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
			end,
		},
	},

	-- "gc" to comment visual regions/lines
	{
		'numToStr/Comment.nvim',
		opts = {},
		config = function()
			require('Comment').setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = '<C-/>',
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = '<C-/>',
				},
			}
		end
	},

	{
		'NTBBloodbath/doom-one.nvim',
		priority = 1000,
		setup = function()
			-- Add color to cursor
			vim.g.doom_one_cursor_coloring = false
			-- Set :terminal colors
			vim.g.doom_one_terminal_colors = true
			-- Enable italic comments
			vim.g.doom_one_italic_comments = false
			-- Enable TS support
			vim.g.doom_one_enable_treesitter = true
			-- Color whole diagnostic text or only underline
			vim.g.doom_one_diagnostics_text_color = false
			-- Enable transparent background

			vim.g.doom_one_transparent_background = true


			-- Pumblend transparency
			vim.g.doom_one_pumblend_enable = false
			vim.g.doom_one_pumblend_transparency = 20

			-- Plugins integration
			vim.g.doom_one_plugin_neorg = true
			vim.g.doom_one_plugin_barbar = false
			vim.g.doom_one_plugin_telescope = true
			vim.g.doom_one_plugin_neogit = true
			vim.g.doom_one_plugin_nvim_tree = true
			vim.g.doom_one_plugin_dashboard = true
			vim.g.doom_one_plugin_startify = true
			vim.g.doom_one_plugin_whichkey = true
			vim.g.doom_one_plugin_indent_blankline = true
			vim.g.doom_one_plugin_vim_illuminate = true
			vim.g.doom_one_plugin_lspsaga = false
		end,
		config = function()
			-- vim.cmd("colorscheme doom-one")
		end
	},
	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = false,
				component_separators = '|',
				section_separators = '',
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { function()
					if vim.bo.filetype == "NvimTree" then
						return "  Explorer"
					else
						local home = vim.fn.expand "$HOME" .. "/"
						local fullpath = vim.fn.expand "%"
						local escaped_home = home:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
						local result = fullpath:gsub("^" .. escaped_home, "")
						return result
					end
				end },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
		},
	},

	{
		-- Add indentation guides even on blank lines
		'lukas-reineke/indent-blankline.nvim',
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help indent_blankline.txt`
		config = function()
			require('ibl').setup {
				enabled = false,
				indent = {
					char = "▏"
				}
			}
		end,
	},

	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
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
		end
	},

	{
		-- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
			'JoosepAlviste/nvim-ts-context-commentstring',
		},
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

				-- Commentstring
				-- context_commentstring = {
				--     enable = true,
				--     enable_autocmd = false,
				-- },

				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = false,

				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<c-space>',
						node_incremental = '<c-space>',
						scope_incremental = '<c-s>',
						node_decremental = '<M-space>',
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							['aa'] = '@parameter.outer',
							['ia'] = '@parameter.inner',
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							[']m'] = '@function.outer',
							[']]'] = '@class.outer',
						},
						goto_next_end = {
							[']M'] = '@function.outer',
							[']['] = '@class.outer',
						},
						goto_previous_start = {
							['[m'] = '@function.outer',
							['[['] = '@class.outer',
						},
						goto_previous_end = {
							['[M'] = '@function.outer',
							['[]'] = '@class.outer',
						},
					},
					swap = {
						enable = true,
						swap_next = {
							['<leader>a'] = '@parameter.inner',
						},
						swap_previous = {
							['<leader>A'] = '@parameter.inner',
						},
					},
				},
			}

			require('ts_context_commentstring').setup({
				enable = true,
				enable_autocmd = false,
			})
		end
	},

	-- Auto pair brackets, quotes, etc
	{
		"windwp/nvim-autopairs",
		-- Optional dependency
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require("nvim-autopairs").setup {}
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end,
	},

	-- Github Copilot
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					panel = {
						enabled = true,
						auto_refresh = false,
						keymap = {
							jump_prev = "[[",
							jump_next = "]]",
							accept = "<CR>",
							refresh = "gr",
							open = "<M-CR>"
						},
						layout = {
							position = "bottom", -- | top | left | right
							ratio = 0.4
						},
					},
					suggestion = {
						enabled = true,
						auto_trigger = true,
						debounce = 75,
						keymap = {
							accept = "<M-l>",
							accept_word = false,
							accept_line = false,
							next = "<M-]>",
							prev = "<M-[>",
							dismiss = "<C-]>",
						},
					},
					filetypes = {
						yaml = false,
						markdown = false,
						help = false,
						gitcommit = false,
						gitrebase = false,
						hgcommit = false,
						svn = false,
						cvs = false,
						["."] = false,
					},
					copilot_node_command = 'node', -- Node.js version must be > 16.x
					server_opts_overrides = {},
				})                  -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
				require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
			end, 100)
		end,
	},

	-- Auto close html tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- Surround Utils
	{
		"tpope/vim-surround",
		-- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
		-- setup = function()
		--  vim.o.timeoutlen = 500
		-- end
	},

	-- Multi cursor
	{ "mg979/vim-visual-multi" },

	-- Todo Comment highlights
	{
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		-- config = function()
		--     require('catppuccin').setup({
		--         no_italic = true,
		--     })
		--     vim.cmd("colorscheme catppuccin")
		-- end
	},
	{
		'goolord/alpha-nvim',
		config = function()
			local alpha = require('alpha')
			local dashboard = require('alpha.themes.dashboard')
			dashboard.section.buttons.val = {
				dashboard.button("n", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
				dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles cwd_only=true <CR>"),
				dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
				dashboard.button("g", "  Lazygit", ":LazyGit<CR>"),
				dashboard.button("l", "󰭖  Load last session for cwd", ":lua require('persistence').load()<CR>"),
				dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
				dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
			}

			local function footer()
				local cmd = "~/.local/bin/bible-parser-xml-rust -f ~/nvi.min.xml random"
				local handle = io.popen(cmd)

				if handle then
					local result = handle:read("*a") or ""
					handle:close()
					return result
				else
					print("Error running command: " .. cmd)
				end

				return "Unable to get Bible verse"
			end

			dashboard.section.footer.val = footer()

			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "Include"
			dashboard.section.buttons.opts.hl = "Keyword"
			dashboard.opts.opts.noautocmd = true
			alpha.setup(dashboard.opts)
		end
	},
	{
		"folke/persistence.nvim",
		event = "BufWritePre",
		module = "persistence",
		config = function()
			require("persistence").setup {
				dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			}
		end,
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- Switch for controlling whether you want autoformatting.
			--  Use :KickstartFormatToggle to toggle autoformatting on or off
			local format_is_enabled = true
			vim.api.nvim_create_user_command('KickstartFormatToggle', function()
				format_is_enabled = not format_is_enabled
				print('Setting autoformatting to: ' .. tostring(format_is_enabled))
			end, {})

			-- Create an augroup that is used for managing our formatting autocmds.
			--      We need one augroup per client to make sure that multiple clients
			--      can attach to the same buffer without interfering with each other.
			local _augroups = {}
			local get_augroup = function(client)
				if not _augroups[client.id] then
					local group_name = 'kickstart-lsp-format-' .. client.name
					local id = vim.api.nvim_create_augroup(group_name, { clear = true })
					_augroups[client.id] = id
				end

				return _augroups[client.id]
			end

			-- Whenever an LSP attaches to a buffer, we will run this function.
			--
			-- See `:help LspAttach` for more information about this autocmd event.
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
				-- This is where we attach the autoformatting for reasonable clients
				callback = function(args)
					local client_id = args.data.client_id
					local client = vim.lsp.get_client_by_id(client_id)
					local bufnr = args.buf

					-- Only attach to clients that support document formatting
					if not client.server_capabilities.documentFormattingProvider then
						return
					end

					-- Tsserver usually works poorly. Sorry you work with bad languages
					-- You can remove this line if you know what you're doing :)
					if client.name == 'tsserver' then
						return
					end

					-- Create an autocmd that will run *before* we save the buffer.
					--  Run the formatting command for the LSP that has just attached.
					vim.api.nvim_create_autocmd('BufWritePre', {
						group = get_augroup(client),
						buffer = bufnr,
						callback = function()
							if not format_is_enabled then
								return
							end

							vim.lsp.buf.format {
								async = false,
								filter = function(c)
									return c.id == client.id
								end,
							}
						end,
					})
				end,
			})
		end
	},
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
			'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
		},
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
			sidebar_filetypes = {
				-- Use the default values: {event = 'BufWinLeave', text = nil}
				NvimTree = true,
				-- Or, specify the text used for the offset:
				undotree = { text = 'undotree' },
				-- Or, specify the event which the sidebar executes when leaving:
				['neo-tree'] = { event = 'BufWipeout' },
				-- Or, specify both
				Outline = { event = 'BufWinLeave', text = 'symbols-outline' },
			},
		},
		version = '^1.0.0', -- optional: only update when a new 1.x version is released
	},
	{
		"no-clown-fiesta/no-clown-fiesta.nvim",
		config = function()
			require("no-clown-fiesta").setup({
				transparent = false, -- Enable this to disable the bg color
				styles = {
					-- You can set any of the style values specified for `:h nvim_set_hl`
					comments = {},
					keywords = {},
					functions = {},
					variables = {},
					type = { bold = true },
					lsp = { underline = true }
				},
			})
		end
	},
	{ 'lunacookies/vim-colors-xcode' },
	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						'class',
						'function',
						'method',
					},
				},
			}
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				source_selector = {
					winbar = true,
					statusline = true
				},
				window = {
					width = 30,
				},
				filesystem = {
					filtered_items = {
						visible = false, -- when true, they will just be displayed differently than normal items
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true, -- only works on Windows for hidden files/directories
						hide_by_name = {
							".DS_Store",
							"thumbs.db",
							--"node_modules",
						},
						hide_by_pattern = {
							--"*.meta",
							--"*/src/*/tsconfig.json",
						},
						always_show = { -- remains visible even if other settings would normally hide it
							--".gitignored",
						},
						never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
							--".DS_Store",
							--"thumbs.db",
						},
						never_show_by_pattern = { -- uses glob style patterns
							--".null-ls_*",
						},
					},
				}
			})
		end

	},
	{ "onsails/lspkind.nvim" },
	{ "puremourning/vimspector" },
	{
		"briones-gabriel/darcula-solid.nvim",
		dependencies = {
			"rktjmp/lush.nvim"
		}
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		}
	},
	{
		'andweeb/presence.nvim',
		config = function()
			-- The setup config table shows all available config options with their default values:
			require("presence").setup({
				-- General options
				auto_update         = true,           -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
				neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
				main_image          = "neovim",       -- Main image display (either "neovim" or "file")
				client_id           = "793271441293967371", -- Use your own Discord application client id (not recommended)
				log_level           = nil,            -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
				debounce_timeout    = 10,             -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
				enable_line_number  = false,          -- Displays the current line number instead of the current project
				blacklist           = {},             -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
				buttons             = true,           -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
				file_assets         = {},             -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
				show_time           = true,           -- Show the timer

				-- Rich Presence text options
				editing_text        = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
				file_explorer_text  = "Browsing %s", -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
				git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
				plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
				reading_text        = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
				workspace_text      = "Working on %s", -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
				line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
			})
		end
	},
	{
		'nvimtools/none-ls.nvim',
		event = 'VeryLazy',
		config = function()
			local null_ls = require('null-ls')

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd,
				}
			})
		end
	}
}, {})

require('telescope').load_extension("fzf")
require("telescope").load_extension("noice")
require("telescope").load_extension("software-licenses")
require("telescope").load_extension("http")

require('nvim-web-devicons').set_icon({
	v = {
		icon = "",
		color = "#4b6c88",
		cterm_color = "24",
		name = "Vlang"
	}
})
