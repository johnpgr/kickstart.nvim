local path_utils = require("utils.file-path")
local harpoon = require("harpoon")

local function ignored_filetypes(current_filetype)
    local ignore = {
        "oil",
        "toggleterm",
        "alpha",
    }

    if vim.tbl_contains(ignore, current_filetype) then
        return true
    end

    return false
end

local function filename()
    if ignored_filetypes(vim.bo.filetype) then
        return ""
    end

    return path_utils.current_path_in_cwd_home_escaped()
end

local function current_user()
    return vim.fn.expand "$USER"
end

local function save_value(value)
    local wrote = false
    local file = io.open("lualine.log", "a+")
    if file and not wrote then
        file:write(vim.inspect(value))
        file:close()
        wrote = true
    end
end

local function current_attached_lsps()
    if ignored_filetypes(vim.bo.filetype) then
        return ""
    end

    local active = vim.lsp.get_active_clients()
    local result = ""

    local ignored = {
        "null-ls",
        "efm",
        "copilot",
    }

    for _, value in ipairs(active) do
        if vim.tbl_contains(ignored, value.name) then
            goto continue
        end

        if not vim.tbl_contains(value.config.filetypes, vim.bo.filetype) then
            goto continue
        end

        -- add a space between each client
        if (result ~= "") then
            result = result .. " "
        end
        result = result .. value.name

        ::continue::
    end

    return result
end

local function current_indentation()
    if ignored_filetypes(vim.bo.filetype) then
        return ""
    end

    local current_indent = vim.bo.expandtab and "spaces" or "tabs"

    local indent_size = -1

    if current_indent == "spaces" then
        indent_size = vim.bo.shiftwidth
    else
        indent_size = vim.bo.tabstop
    end

    return current_indent .. " " .. indent_size
end

local function string_includes(str, substr)
    return string.find(str, substr, 1, true) ~= nil
end

local function harpoon_component()
    local total_marks = harpoon:list():length()
    if total_marks == 0 then
        return ""
    end

    local current_mark_name = path_utils.current_file_path_in_cwd()
    local current_mark_index = -1

    for index, mark in ipairs(harpoon:list().items) do
        if string_includes(current_mark_name, mark.value) then
            current_mark_index = index
        end
    end

    if (current_mark_index == -1) then
        return string.format("󱡅 %s/%d", "—", total_marks)
    end

    return string.format("󱡅 %d/%d", current_mark_index, total_marks)
end

local function new_line_format()
    if ignored_filetypes(vim.bo.filetype) then
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
                theme = 'auto',
                icons_enabled = true,
                component_separators = '',
                section_separators = { left = '', right = '' }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', current_user, 'diff', 'diagnostics' },
                lualine_c = { harpoon_component, 'filename' },
                lualine_x = { current_attached_lsps },
                lualine_y = { 'filetype', 'encoding', new_line_format, current_indentation },
                lualine_z = { 'location' }
            }
        },
    },
}
