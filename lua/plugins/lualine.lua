local function filename()
    if vim.bo.filetype == "NvimTree" then
        return "  Explorer"
    else
        local home = vim.fn.expand "$HOME" .. "/"
        local fullpath = vim.fn.expand "%"
        local escaped_home = home:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
        local result = fullpath:gsub("^" .. escaped_home, "")
        return result
    end
end

local function current_user()
    return vim.fn.expand "$USER"
end

local function current_attached_lsps()
    local active = vim.lsp.get_active_clients()
    local result = ""
    for _, value in ipairs(active) do
        -- add a space between each client
        if (result ~= "") then
            result = result .. " "
        end
        result = result .. value.name
    end

    return result
end

local function current_indentation()
    local indent_size = vim.bo.shiftwidth
    return indent_size .. " spaces"
end

local function current_tab_mode()
    local tab_mode = vim.bo.expandtab and "spaces" or "tabs"
    return tab_mode
end

return {
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = true,
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', current_user, 'diff', 'diagnostics' },
                lualine_c = { filename },
                lualine_x = { current_attached_lsps },
                lualine_y = { 'filetype', 'encoding', current_tab_mode, current_indentation },
                lualine_z = { 'location' }
            },
        },
    },
}
