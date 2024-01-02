local togglers = require('utils.toggle')
local harpoon = require('harpoon')
local harpoon_utils = require('utils.harpoon')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Select all
vim.keymap.set('n', '<c-a>', 'gg<S-v>G')

-- Clear search highlights
vim.keymap.set('n', '<leader>ch', ':noh<CR>', { noremap = true, silent = true, desc = 'Clear search highlights' })

-- Duplicate lines
vim.keymap.set('n', '<M-J>', ':t.<CR>', { noremap = true, silent = true, desc = 'Duplicate line below' })
vim.keymap.set('n', '<M-K>', ':t-1<CR>', { noremap = true, silent = true, desc = 'Duplicate line above' })

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

-- Move lines
vim.keymap.set('v', '<s-j>', ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = 'Move line down' })
vim.keymap.set('v', '<s-k>', ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = 'Move line up' })

-- Select all occurences of word under cursor
vim.cmd([[
    nmap <C-M-n> <Plug>(VM-Select-All)
    imap <C-M-n> <ESC><Plug>(VM-Select-All)
    vmap <C-M-n> <ESC><Plug>(VM-Select-All)
]])

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

-- Open explorer
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = '[E]xplorer', silent = true })

-- Telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown())
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').git_files, { desc = '[S]earch [G]it files' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sm', ':Telescope noice<CR>',
    { desc = '[S]earch Notification [M]essages', noremap = true, silent = true })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>st', require('telescope.builtin').live_grep, { desc = '[S]earch by [T]ext' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- this is maybe not that useful for me. <leader>sr could be replaced
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').colorscheme,
    { desc = '[S]earch [C]olorscheme', noremap = true, silent = true })
vim.keymap.set('n', '<leader>sl', require('telescope').extensions['software-licenses'].find,
    { desc = '[S]earch [L]icenses', noremap = true, silent = true })
vim.keymap.set('n', '<leader>sh', require('telescope').extensions.http.list,
    { desc = '[S]earch [H]TTP status codes', noremap = true, silent = true })
vim.keymap.set('n', '<leader>su', require('telescope').extensions.undo.undo,
    { desc = '[S]earch [U]ndo history', noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [D]iagnostic [F]loating message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist' })

-- Handy toggles
vim.keymap.set('n', '<leader>ts', togglers.spaces_width, { desc = "Toggle [T]ab [S]ize", noremap = true, silent = true })
vim.keymap.set('n', '<leader>ti', togglers.tabs_spaces,
    { desc = "[T]oggle [I]ndentation (Tabs <-> Spaces)", noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>tc', '<cmd>TextCaseOpenTelescope<CR>',
    { desc = "[T]ext [C]ase converter", noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>cs', function() require("textcase").current_word('to_snake_case') end, {
    desc = "[C]hange word to [S]nake case", noremap = true, silent = true
})

-- Persistence
vim.keymap.set('n', '<leader>pc', "<cmd>lua require('persistence').load()<cr>",
    { desc = 'Restore last session for cwd', silent = true })
vim.keymap.set('n', '<leader>pl', "<cmd>lua require('persistence').load({ last = true })<cr>", {
    desc = 'Restore last session', silent = true
})
vim.keymap.set('n', '<leader>pQ', "<cmd>lua require('persistence').stop()<cr>", {
    desc = 'Quit without saving session', silent = true
})

vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { desc = 'Open Lazygit' })

-- Harpoon
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader><space>", function() harpoon_utils.toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end)
vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<s-tab>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<tab>", function() harpoon:list():next() end)
