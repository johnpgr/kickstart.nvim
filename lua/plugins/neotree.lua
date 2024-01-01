return {
    -- File explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-web-devicons",
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
    }
}
