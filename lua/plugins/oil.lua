return {
    {
        'stevearc/oil.nvim',
        opts = {
            keymaps = {
                ['<backspace>'] = 'actions.parent',
                ['<space>'] = 'actions.select',
            }
        },
        -- Optional dependencies
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    }
}
