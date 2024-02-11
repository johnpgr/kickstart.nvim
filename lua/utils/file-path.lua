local function current_file_path_home_escaped()
    local home_path = vim.fn.expand "$HOME"
    local current_file_path = vim.fn.expand "%"
    return current_file_path:gsub(home_path, "")
end

return {
    current_file_path_home_escaped = current_file_path_home_escaped,
}
