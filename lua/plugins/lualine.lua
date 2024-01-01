return {
    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { function()
                    if vim.bo.filetype == "NvimTree" then
                        return "  Explorer"
                    else
                        local home = vim.fn.expand "$HOME" .. "/"
                        local fullpath = vim.fn.expand "%"
                        local escaped_home = home:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
                        local result = fullpath:gsub("^" .. escaped_home, "")
                        return result
                    end
                end },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        },
    },
}
