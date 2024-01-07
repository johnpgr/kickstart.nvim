return {
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
    { 'lunacookies/vim-colors-xcode' },
    {
        "briones-gabriel/darcula-solid.nvim",
        dependencies = {
            "rktjmp/lush.nvim"
        }
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                --- @usage 'auto'|'main'|'moon'|'dawn'
                variant = 'main',
                --- @usage 'main'|'moon'|'dawn'
                dark_variant = 'main',
                bold_vert_split = false,
                dim_nc_background = false,
                disable_background = false,
                disable_float_background = true,
                disable_italics = true,

                --- @usage string hex value or named color from rosepinetheme.com/palette
                groups = {
                    background = 'base',
                    background_nc = '_experimental_nc',
                    panel = 'surface',
                    panel_nc = 'base',
                    border = 'highlight_med',
                    comment = 'muted',
                    link = 'iris',
                    punctuation = 'subtle',

                    error = 'love',
                    hint = 'iris',
                    info = 'foam',
                    warn = 'gold',

                    headings = {
                        h1 = 'iris',
                        h2 = 'foam',
                        h3 = 'rose',
                        h4 = 'gold',
                        h5 = 'pine',
                        h6 = 'foam',
                    }
                    -- or set all headings at once
                    -- headings = 'subtle'
                },

                -- Change specific vim highlight groups
                -- https://github.com/rose-pine/neovim/wiki/Recipes
                highlight_groups = {
                    ColorColumn = { bg = 'foam', blend = 10 },

                    -- Blend colours against the "base" background
                    CursorLine = { bg = 'foam', blend = 10 },
                    StatusLine = { fg = 'love', bg = 'foam', blend = 10 },

                    -- By default each group adds to the existing config.
                    -- If you only want to set what is written in this config exactly,
                    -- you can set the inherit option:
                    Search = { bg = 'gold', inherit = false },
                }
            })

            -- Set colorscheme after options
            vim.cmd('colorscheme rose-pine')
        end
    },
    {
        'navarasu/onedark.nvim',
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
                contrast = "soft",
                transparent_mode = true
            })
        end
    },
    {
        'NTBBloodbath/doom-one.nvim',
        -- priority = 1000,
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
    }
}
