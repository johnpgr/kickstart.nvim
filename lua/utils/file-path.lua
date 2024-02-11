local function full_file_path_home_escaped()
    local home_path = vim.fn.expand "$HOME"
    local cwd = vim.fn.getcwd()
    local current_buffer_path = vim.fn.expand "%"

    if(current_buffer_path == "") then
        return ""
    end

    local full_current_file_path = cwd .. "/" .. current_buffer_path

    return full_current_file_path:gsub(home_path, "~")
end

local function current_file_path_in_cwd()
    return vim.fn.expand "%"
end

return {
    full_file_path_home_escaped = full_file_path_home_escaped,
    current_file_path_in_cwd = current_file_path_in_cwd
}
