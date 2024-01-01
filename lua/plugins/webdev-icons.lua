return {
    {
        'nvim-tree/nvim-web-devicons',
        priority = 1000,
        name = 'nvim-web-devicons',
        init = function()
            require('nvim-web-devicons').set_icon({
                v = {
                    icon = "",
                    color = "#4b6c88",
                    cterm_color = "24",
                    name = "Vlang"
                }
            })
        end
    }
}
