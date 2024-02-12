local path_utils = require("utils.file-path")
local harpoon = require("harpoon")

local function filename()
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return path_utils.current_path_in_cwd_home_escaped()
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
    if vim.bo.filetype == "alpha" then
        return ""
    end

    local current_indent = vim.bo.expandtab and "spaces" or "tabs"

    local indent_size = vim.bo.shiftwidth
    return current_indent .. ": " .. indent_size
end


local function harpoon_component()
    local total_marks = harpoon:list():length()
    if total_marks == 0 then
        return ""
    end

    local current_mark_name = path_utils.current_file_path_in_cwd()
    local current_mark_index = -1

    for index, mark in ipairs(harpoon:list().items) do
        if mark.value == current_mark_name then
            current_mark_index = index
        end
    end

    if(current_mark_index == -1) then
        return string.format("󱡅 %s/%d", "—", total_marks)
    end

    return string.format("󱡅 %d/%d", current_mark_index, total_marks)
end

local function new_line_format()
    if vim.bo.filetype == "alpha" then
        return ""
    end

    local format = vim.bo.fileformat

    if format == "unix" then
        return "lf"
    elseif format == "dos" then
        return "crlf"
    else
        return "cr"
    end
end

return {
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                theme = 'catppuccin',
                icons_enabled = true,
                component_separators = '',
                section_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', current_user, 'diff', 'diagnostics' },
                lualine_c = { harpoon_component, filename },
                lualine_x = { current_attached_lsps },
                lualine_y = { 'filetype', 'encoding', new_line_format, current_indentation },
                lualine_z = { 'location' }
            }
        },
    },
}
