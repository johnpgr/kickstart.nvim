-- [[ Basic Keymaps ]]

local function close_buffer()
    local buftype = vim.bo.buftype
    if buftype == 'terminal' then
        vim.cmd('bd!')
    else
        vim.cmd('BufferClose')
    end
end

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Select all
vim.keymap.set('n', '<c-a>', 'gg<S-v>G')


-- Split generation
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { silent = true, desc = 'Vertical split' })
vim.keymap.set('n', '<leader>h', ':split<CR>', { silent = true, desc = 'Horizontal split' })

-- Move between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Resize splits
vim.keymap.set('n', '<C-up>', ':horizontal resize -3<CR>', { silent = true })
vim.keymap.set('n', '<C-down>', ':horizontal resize +3<CR>', { silent = true })
vim.keymap.set('n', '<C-left>', ':vertical resize -3<CR>', { silent = true })
vim.keymap.set('n', '<C-right>', ':vertical resize +3<CR>', { silent = true })

-- Terminal mode
vim.keymap.set('n', '<leader>t', ':terminal<CR>', { silent = true, desc = 'Open terminal' })
-- Exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })

-- Move lines
vim.keymap.set('v', '<s-j>', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move line down' })
vim.keymap.set('v', '<s-k>', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move line up' })

-- Scrolling remaps
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep selection when indenting multiple lines
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Open Alpha dashboard
vim.keymap.set('n', '<leader>;', '<cmd>Alpha<cr>', { noremap = true, silent = true, desc = "Open Dashboard" })

-- ToggleTerm Keymaps
-- vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal size=15<CR>',
--     { noremap = true, silent = true, desc = "Toggle horizontal terminal" }) -- Horizontal terminal
-- vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical size=80<CR>',
--     { noremap = true, silent = true, desc = "Toggle vertical terminal" })   -- Vertical terminal
-- vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=float size=100<CR>',
--     { noremap = true, silent = true, desc = "Toggle terminal" })            -- Toggle terminal
--
-- function _G.set_terminal_keymaps()
--     local opts = { noremap = true, silent = true }
--     vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)       -- Esc to exit terminal mode
--     vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)          -- jk to exit terminal mode
--     vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-w>h]], opts) -- Navigate between splits
--     vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-w>j]], opts) -- Navigate between splits
--     vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-w>k]], opts) -- Navigate between splits
--     vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-w>l]], opts) -- Navigate between splits
-- end
--
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()') -- Set keymaps when opening terminal

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = '[E]xplorer', silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [D]iagnostic [F]loating message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist' })

-- Function to toggle shiftwidth and tabstop
local function toggle_spaces_width()
    local currentWidth = vim.opt.shiftwidth:get()
    local currentTabstop = vim.opt.tabstop:get()

    if currentWidth == 2 and currentTabstop == 2 then
        vim.opt.shiftwidth = 4
        vim.opt.tabstop = 4
    else
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
    end
    -- Print a message to indicate the current values
    print("Shiftwidth: " .. vim.opt.shiftwidth:get() .. " Tabstop: " .. vim.opt.tabstop:get())
end

vim.keymap.set('n', '<leader>ts', toggle_spaces_width, { desc = "Toggle Tab size" })

-- Persistence
vim.keymap.set('n', '<leader>pc', "<cmd>lua require('persistence').load()<cr>",
    { desc = 'Restore last session for cwd', silent = true })
vim.keymap.set('n', '<leader>pl', "<cmd>lua require('persistence').load({ last = true })<cr>", {
    desc = 'Restore last session', silent = true
})
vim.keymap.set('n', '<leader>pQ', "<cmd>lua require('persistence').stop()<cr>", {
    desc = 'Quit without saving session', silent = true
})

vim.keymap.set('n', '<leader>gg', Toggle_lazygit, { desc = 'Open Lazygit' })

-- Tabs
vim.keymap.set('n', '<tab>', ':BufferNext<CR>', { desc = 'Next tab', noremap = true, silent = true })
vim.keymap.set('n', '<s-tab>', ':BufferPrevious<CR>', { desc = 'Previous tab', noremap = true, silent = true })
vim.keymap.set('n', '<A-1>', ':BufferGoto 1<CR>', { desc = 'Go to tab 1', noremap = true, silent = true })
vim.keymap.set('n', '<A-2>', ':BufferGoto 2<CR>', { desc = 'Go to tab 2', noremap = true, silent = true })
vim.keymap.set('n', '<A-3>', ':BufferGoto 3<CR>', { desc = 'Go to tab 3', noremap = true, silent = true })
vim.keymap.set('n', '<A-4>', ':BufferGoto 4<CR>', { desc = 'Go to tab 4', noremap = true, silent = true })
vim.keymap.set('n', '<A-5>', ':BufferGoto 5<CR>', { desc = 'Go to tab 5', noremap = true, silent = true })
vim.keymap.set('n', '<A-6>', ':BufferGoto 6<CR>', { desc = 'Go to tab 6', noremap = true, silent = true })
vim.keymap.set('n', '<A-7>', ':BufferGoto 7<CR>', { desc = 'Go to tab 7', noremap = true, silent = true })
vim.keymap.set('n', '<A-8>', ':BufferGoto 8<CR>', { desc = 'Go to tab 8', noremap = true, silent = true })
vim.keymap.set('n', '<A-9>', ':BufferGoto 9<CR>', { desc = 'Go to tab 9', noremap = true, silent = true })
vim.keymap.set('n', '<A-0>', ':BufferLast<CR>', { desc = 'Go to last tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>q', close_buffer, { noremap = true, silent = true, desc = 'Kill buffer' })
