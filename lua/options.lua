-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Set indentation to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Line numbers
vim.opt.relativenumber = true
vim.wo.number = true
vim.wo.numberwidth = 2

-- Cursor line highlighting
vim.opt.cursorline = true

-- Line wrapping
vim.opt.wrap = false

-- Set colorcolumn to 80 characters
vim.opt.colorcolumn = '80'

-- Set cursor to block on insert mode
vim.opt.guicursor = 'n-v-c-i:block'

-- Disable search results highlighting
vim.o.hlsearch = false

-- Enable break indent
vim.o.breakindent = true

-- Enable smart indent
vim.o.smartindent = true

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

-- Set terminal colors
vim.o.termguicolors = true

-- Set listchars
vim.cmd("set list")
vim.cmd("set listchars=tab:··,space:·,trail:·,extends:→,precedes:←,nbsp:␣")

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Better splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Better scrolling experience
vim.opt.scrolloff = 8

if vim.g.neovide then
    vim.o.guifont = "IosevkaTerm Nerd Font Mono:h16"
    vim.g.neovide_scroll_animation_length = 0.2
    vim.g.neovide_scale_factor = 1.25
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)
end
