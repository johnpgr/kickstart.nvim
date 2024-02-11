local function current_path_in_cwd_home_escaped()
    local home_path = vim.fn.expand "$HOME"
    local current_buffer_path = vim.fn.expand "%"

    if(current_buffer_path == "") then
        return ""
    end

    return current_buffer_path:gsub(home_path, "~")
end

local function current_file_path_in_cwd()
    return vim.fn.expand "%"
end

return {
    current_file_path_in_cwd = current_file_path_in_cwd,
    current_path_in_cwd_home_escaped = current_path_in_cwd_home_escaped
}
