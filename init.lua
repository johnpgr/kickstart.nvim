-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Shortcuts
-- vim.cmd [[ nmap <C-/> gcc ]]
-- vim.cmd [[ nmap <C-_> gcc ]]
-- vim.cmd [[ vmap <C-/> gc ]]
-- vim.cmd [[ vmap <C-_> gc ]]

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

-- Plugins
require('lazy').setup({
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
            vim.cmd("colorscheme gruvbox")
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
        },
    },

    -- {
    --     -- Add indentation guides even on blank lines
    --     'lukas-reineke/indent-blankline.nvim',
    --     -- Enable `lukas-reineke/indent-blankline.nvim`
    --     -- See `:help indent_blankline.txt`
    --     config = function()
    --         require('ibl').setup {
    --             char = '|',
    --             show_trailing_blankline_indent = false,
    --         }
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
                            accept = "<Tab>",
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

    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
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
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = function()
            require("toggleterm").setup({
                -- size can be a number or function which is passed the current terminal
                size = 80,
                open_mapping = [[<c-\>]],
                hide_numbers = true,      -- hide the number column in toggleterm buffers
                shade_filetypes = {},
                shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
                shading_factor = 2,       -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
                start_in_insert = true,
                insert_mappings = true,   -- whether or not the open mapping applies in insert mode
                terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
                persist_size = true,
                persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
                direction = 'vertical',
                close_on_exit = true,     -- close the terminal window when the process exits
                shell = vim.o.shell,
                auto_scroll = true,       -- automatically scroll to the bottom on terminal output
                float_opts = {
                    border = 'curved',
                    winblend = 0,
                    highlights = {
                        border = "Normal",
                        background = "Normal"
                    }
                }
            })
        end
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

    -- Save cursor place on close
    {
        "ethanholz/nvim-lastplace",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    },

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
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                command_palette = true,
            },
            lsp = {
                signature = {
                    auto_open = {
                        enabled = false
                    }
                }
            }
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            {
                "rcarriga/nvim-notify",
                config = function()
                    require("notify").setup({
                        background_colour = "#000000"
                    })
                end
            },
        }
    },
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')
            dashboard.section.buttons.val = {
                dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
                dashboard.button("e", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles <CR>"),
                dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
                dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
            }
            local function footer()
                local url = 'http://labs.bible.org/api/?passage=random&type=json'
                local http = require('socket.http')
                local json = require('lunajson')

                local res, status, _ = http.request(url)

                if status == 200 then
                    local json_res = json.decode(res)[1] or {}

                    local bookname = json_res.bookname or ''
                    local chapter = json_res.chapter or ''
                    local verse_num = json_res.verse or ''
                    local text = json_res.text or '' 
                    text = text:gsub("(%.[ ])", "%1\n")

                    return bookname .. " " .. chapter .. ":" .. verse_num .. "\n" .. text
                end

                return "Could not fetch random Bible verse"
            end

            dashboard.section.footer.val = footer()

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"

            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end
    },
}, {})

-- Open Alpha dashboard
vim.keymap.set('n', '<leader>;', '<cmd>Alpha<cr>', { noremap = true, silent = true, desc = "Open Dashboard" })

-- ToggleTerm Keymaps

vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal size=15<CR>',
    { noremap = true, silent = true, desc = "Toggle horizontal terminal" }) -- Horizontal terminal
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical size=80<CR>',
    { noremap = true, silent = true, desc = "Toggle vertical terminal" })   -- Vertical terminal
vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=float size=100<CR>',
    { noremap = true, silent = true, desc = "Toggle terminal" })            -- Toggle terminal

function _G.set_terminal_keymaps()
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)       -- Esc to exit terminal mode
    vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)          -- jk to exit terminal mode
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts) -- Navigate between splits
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts) -- Navigate between splits
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts) -- Navigate between splits
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-w>l]], opts) -- Navigate between splits
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()') -- Set keymaps when opening terminal

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Cursor style
vim.cmd('set guicursor=n-v-c-i:block')

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Kill buffer
vim.keymap.set('n', '<leader>q', ':bdelete<CR>', { silent = true, desc = 'Kill buffer' })

-- Split generation
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { silent = true, desc = 'Vertical split' })
vim.keymap.set('n', '<leader>h', ':split<CR>', { silent = true, desc = 'Horizontal split' })

-- Move between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Resize splits
vim.keymap.set('n', '<C-up>', ':horizontal resize -3<CR>', { silent = true })
vim.keymap.set('n', '<C-down>', ':horizontal resize +3<CR>', { silent = true })
vim.keymap.set('n', '<C-left>', ':vertical resize -3<CR>', { silent = true })
vim.keymap.set('n', '<C-right>', ':vertical resize +3<CR>', { silent = true })

-- Move lines
vim.keymap.set('v', '<s-j>', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move line down' })
vim.keymap.set('v', '<s-k>', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move line up' })

-- Scrolling remaps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
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
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>e', ':Neotree toggle right<CR>', { desc = '[E]xplorer', silent = true })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

    -- Commentstring
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },

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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [D]iagnostic [F]loating message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist' })

-- Function to toggle shiftwidth and tabstop
local function toggle_spaces_width()
    local currentWidth = vim.opt.shiftwidth:get()
    local currentTabstop = vim.opt.tabstop:get()

    if currentWidth == 2 and currentTabstop == 2 then
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
    else
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
    -- Print a message to indicate the current values
    print("Shiftwidth: " .. vim.opt.shiftwidth:get() .. " Tabstop: " .. vim.opt.tabstop:get())
end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>ls', vim.lsp.buf.signature_help, '[L]SP [S]ignature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- Create a command `:ToggleSpacesWidth` local to the current buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'ToggleSpacesWidth', function(_)
        toggle_spaces_width()
    end, { desc = 'Toggle spaces width in current buffer (4 <-> 2)' })

    nmap('<leader>lf', vim.lsp.buf.format, '[L]SP [F]ormat current file')
    nmap('<leader>ts', toggle_spaces_width, 'Toggle Spaces width')
end

-- Lazygit
local function toggle_lazygit()
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new {
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
            border = "none",
            width = 100000,
            height = 100000,
        },
        on_open = function(_)
            vim.cmd "startinsert!"
        end,
        on_close = function(_) end,
        count = 99,
    }
    lazygit:toggle()
end

vim.keymap.set('n', '<leader>gg', toggle_lazygit, { desc = 'Open Lazygit' })

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
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

-- V-Analyzer
-- local configs = require('lspconfig.configs')
-- local lspconfig = require('lspconfig')
-- if not configs['v-analyzer'] then
--     configs['v-analyzer'] = {
--         default_config = {
--             cmd = { 'v-analyzer' },
--             root_dir = lspconfig.util.root_pattern('.git', '.v-analyzer'),
--             filetypes = { 'v', 'vlang' },
--         },
--     }
-- end
-- lspconfig['v-analyzer'].setup {}
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
-- vim: ts=2 sts=2 sw=2 et
