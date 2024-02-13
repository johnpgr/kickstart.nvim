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
vim.api.nvim_create_user_command("VAnalyzeClear", function() vim.cmd("!v-analyzer clear-cache") end,
    { desc = "Clear V Analyzer cache" })

-- Don't display color column in oil
vim.cmd("autocmd FileType oil setlocal colorcolumn=0")
-- Don't spell check in toggleterm
vim.cmd("autocmd FileType toggleterm setlocal nospell")

-- vim.cmd([[
--     highlight ExtraWhitespace ctermbg=red guibg=red
--     au ColorScheme * highlight ExtraWhitespace guibg=red
--     au InsertEnter * if &filetype != 'toggleterm' && &filetype != 'mason' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
--     au InsertLeave * if &filetype != 'toggleterm' && &filetype != 'mason' | match ExtraWhitespace /\s\+$/ | endif
-- ]])
