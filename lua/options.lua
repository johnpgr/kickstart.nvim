-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false

-- Set colorcolumn to 80 characters
vim.opt.colorcolumn = '80'

-- Set cursor to block on insert mode
vim.opt.guicursor = 'n-v-c-i:block'

-- Make line numbers default
vim.wo.number = true
vim.wo.numberwidth = 2

-- Disable search results highlighting
vim.o.hlsearch = false
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Set spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_us'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- display spaces and tab characters as `·`
-- vim.cmd([[
--     set listchars=tab:··,trail:·,nbsp:·,space:·
--     set list
-- ]])
