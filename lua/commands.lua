-- Highlight extra whitespace
vim.cmd([[match errorMsg /\s\+$/]])

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Create a command `:Theme` to list themes
vim.api.nvim_create_user_command("Theme",
    function(_)
        require('telescope.builtin').colorscheme()
    end, { desc = "Change theme" })

-- Create a command `:Licenses` to list common software licenses
vim.api.nvim_create_user_command("Licenses",
    require('telescope').extensions['software-licenses'].find, { desc = "Search licenses" })

-- Create a command :SnakeCase to change a word to snake case
vim.api.nvim_create_user_command("SnakeCase",
    function() require("textcase").current_word('to_snake_case') end, { desc = "Change word to snake case" })

-- Clear and restart v-analyzer
vim.api.nvim_create_user_command("VAnalyzeClear", function() vim.cmd("!v-analyzer clear-cache") end,
    { desc = "Clear V Analyzer cache" })

-- Autoenable treesitter highlight on vlang files
vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = "*.v",
    command = "TSEnable highlight"
})
