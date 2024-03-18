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
                max_width = 100,
                max_height = 30
            }
        },
        -- Optional dependencies
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }
}
