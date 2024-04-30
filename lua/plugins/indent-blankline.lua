return {
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
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
