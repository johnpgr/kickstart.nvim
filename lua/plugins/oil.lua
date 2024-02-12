return {
    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ['<backspace>'] = 'actions.parent',
                ['<space>'] = 'actions.select',
                ['q'] = 'actions.close'
            },
            float = {
                border = "none",
                max_width = 100,
                max_height = 25
            }
        },
        -- Optional dependencies
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }
}
