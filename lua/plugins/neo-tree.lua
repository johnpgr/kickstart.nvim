return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        opts = {
            window = {
                width = 30
            },
            auto_clean_after_session_restore = true,
            close_if_last_window = true,
            sources = { "filesystem", "buffers", "git_status" },
            source_selector = {
                winbar = true,
                content_layout = "center",
                sources = {
                    { source = "filesystem" },
                    { source = "buffers" },
                    { source = "git_status" },
                    { source = "diagnostics" }
                },
            },
        }
    }
}
