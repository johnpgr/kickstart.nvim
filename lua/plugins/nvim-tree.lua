return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true
                },
                renderer = {
                    indent_markers = {
                        enable = true,
                    }
                }

            })
        end
    }
}
