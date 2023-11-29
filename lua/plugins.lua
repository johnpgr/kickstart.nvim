-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
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

return {
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
                    line = '<C-_>',
                },
                ---LHS of operator-pending mappings in NORMAL and VISUAL mode
                opleader = {
                    ---Line-comment keymap
                    line = '<C-_>',
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
                    local home = vim.fn.expand "$HOME"

                    if vim.bo.filetype == "NvimTree" then
                        return "  Explorer"
                    else
                        local fullpath = vim.fn.expand "%"
                        local path = fullpath.gsub(fullpath, home, "~")
                        return path
                    end
                end },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        },
    },

    -- {
    --     -- Add indentation guides even on blank lines
    --     'lukas-reineke/indent-blankline.nvim',
    --     -- Enable `lukas-reineke/indent-blankline.nvim`
    --     -- See `:help indent_blankline.txt`
    --     config = function()
    --         require('ibl').setup {}
    --     end,
    -- },

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
        },
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        build = ':TSUpdate',
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
                })                                 -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
                require("copilot_cmp").setup()     -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
            end, 100)
        end,
    },

    -- LSP Signature on write
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         bind = true,
    --         handler_opts = {
    --             border = "none"
    --         },
    --         always_trigger = false,
    --     },
    --     config = function(_, opts) require 'lsp_signature'.setup(opts) end
    -- },

    -- Auto close html tags
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- -- File explorer
    -- {
    --     "nvim-neo-tree/neo-tree.nvim",
    --     branch = "v3.x",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    --         "MunifTanjim/nui.nvim",
    --     },
    -- },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {
                view = {
                    width = 30,
                },
                git = {
                    enable = true,
                    ignore = false,
                    timeout = 500
                },
                on_attach = function(bufnr)
                    local api = require "nvim-tree.api"

                    local function opts(desc)
                        return {
                            desc = "nvim-tree: " .. desc,
                            buffer = bufnr,
                            noremap = true,
                            silent = true,
                            nowait = true
                        }
                    end

                    -- default mappings
                    vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
                    vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
                    vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
                    vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
                    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
                    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
                    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
                    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
                    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
                    vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
                    vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
                    vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
                    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
                    vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
                    vim.keymap.set('n', 'bd', api.marks.bulk.delete, opts('Delete Bookmarked'))
                    vim.keymap.set('n', 'bt', api.marks.bulk.trash, opts('Trash Bookmarked'))
                    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
                    vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle Filter: No Buffer'))
                    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
                    vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Filter: Git Clean'))
                    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
                    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
                    vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
                    vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
                    vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
                    vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
                    vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
                    vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
                    vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
                    vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
                    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
                    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
                    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Filter: Dotfiles'))
                    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
                    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
                    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
                    vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
                    vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
                    vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
                    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
                    vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
                    vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
                    vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
                    vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
                    vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
                    vim.keymap.set('n', 'u', api.fs.rename_full, opts('Rename: Full Path'))
                    vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Filter: Hidden'))
                    vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
                    vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
                    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
                    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
                    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
                    vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
                    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close directory'))
                end
            }
        end,
    },

    -- Highlight matching occurrences of word under cursor
    {
        "RRethy/vim-illuminate",
        config = function()
            -- default configuration
            require('illuminate').configure({
                -- providers: provider used to get references in the buffer, ordered by priority
                providers = {
                    'lsp',
                    'treesitter',
                    'regex',
                },
                -- delay: delay in milliseconds
                delay = 100,
                -- filetype_overrides: filetype specific overrides.
                -- The keys are strings to represent the filetype while the values are tables that
                -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
                filetype_overrides = {},
                -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
                filetypes_denylist = {
                    'dirbuf',
                    'dirvish',
                    'fugitive',
                },
                -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
                -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
                filetypes_allowlist = {},
                -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
                -- See `:help mode()` for possible values
                modes_denylist = {},
                -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
                -- See `:help mode()` for possible values
                modes_allowlist = {},
                -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_denylist = {},
                -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
                -- Only applies to the 'regex' provider
                -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
                providers_regex_syntax_allowlist = {},
                -- under_cursor: whether or not to illuminate under the cursor
                under_cursor = true,
                -- large_file_cutoff: number of lines at which to use large_file_config
                -- The `under_cursor` option is disabled when this cutoff is hit
                large_file_cutoff = nil,
                -- large_file_config: config to use for large files (based on large_file_cutoff).
                -- Supports the same keys passed to .configure
                -- If nil, vim-illuminate will be disabled for large files.
                large_file_overrides = nil,
                -- min_count_to_highlight: minimum number of matches required to perform highlighting
                min_count_to_highlight = 1,
                -- should_enable: a callback that overrides all other settings to
                -- enable/disable illumination. This will be called a lot so don't do
                -- anything expensive in it.
                should_enable = function(bufnr) return true end,
                -- case_insensitive_regex: sets regex case sensitivity
                case_insensitive_regex = false,
            })
        end
    },

    -- Toggle terminals inside editor
    -- {
    --     'akinsho/toggleterm.nvim',
    --     version = "*",
    --     config = function()
    --         require("toggleterm").setup({
    --             -- size can be a number or function which is passed the current terminal
    --             size = 15,
    --             open_mapping = [[<c-\>]],
    --             hide_numbers = true,      -- hide the number column in toggleterm buffers
    --             shade_filetypes = {},
    --             shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    --             shading_factor = 2,       -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
    --             start_in_insert = true,
    --             insert_mappings = true,   -- whether or not the open mapping applies in insert mode
    --             terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    --             persist_size = true,
    --             persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
    --             direction = 'horizontal',
    --             close_on_exit = true,     -- close the terminal window when the process exits
    --             shell = vim.o.shell,
    --             auto_scroll = true,       -- automatically scroll to the bottom on terminal output
    --             float_opts = {
    --                 border = 'curved',
    --                 winblend = 0,
    --                 highlights = {
    --                     border = "Normal",
    --                     background = "Normal"
    --                 }
    --             }
    --         })
    --     end
    -- },

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

    -- Save cursor place on close
    -- {
    --     "ethanholz/nvim-lastplace",
    --     config = function()
    --         require("nvim-lastplace").setup({
    --             lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    --             lastplace_ignore_filetype = {
    --                 "gitcommit", "gitrebase", "svn", "hgcommit",
    --             },
    --             lastplace_open_folds = true,
    --         })
    --     end,
    -- },

    -- Todo Comment highlights
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end,
    },
    { "ollykel/v-vim" },
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
                local cmd = "~/.local/bin/bible-reader -f ~/bible-por-nvi.xml random -v 5"
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
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
            -- Set the filetypes which barbar will offset itself for
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
    {
        "michaelb/sniprun",
        branch = "master",

        build = "sh install.sh",
        -- do 'sh install.sh 1' if you want to force compile locally
        -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

        config = function()
            require("sniprun").setup({
                interpreter_options = {
                    Generic = {
                        Vlang = {
                            supported_filetypes = { "vlang" },
                            extension = ".v",
                            interpreter = "v run",
                            compiler = "",
                        },
                        Bun = {
                            supported_filetypes = { "ts" },
                            extension = ".ts",
                            interpreter = "bun repl",
                            compiler = "",
                        }
                    }
                },
                selected_interpreters = { 'Generic' },
                repl_enable = { 'Generic_Vlang' }
            })
        end,
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
                enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
                patterns = {     -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
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
        "Hubro/nvim-splitrun",
        opts = {},
    },
}
