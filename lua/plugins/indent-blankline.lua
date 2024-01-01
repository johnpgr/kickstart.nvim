return {
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        config = function()
            require('ibl').setup {
                enabled = true,
                indent = {
                    char = "▏"
                },
                scope = {
                    enabled = false
                }
            }
        end,
    },
}
