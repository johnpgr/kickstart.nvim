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

return {}
