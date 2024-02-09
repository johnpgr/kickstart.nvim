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
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { silent = true, desc = '[V]ertical split' })
vim.keymap.set('n', '<leader>h', ':split<CR>', { silent = true, desc = '[H]orizontal split' })

-- Move between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Re size split's
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
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

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
vim.keymap.set("n", "<leader>ss", function()
    require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
end, { desc = "[S]earch [S]pelling [S]uggestions" })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/',
    function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown()) end,
    { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').git_files, { desc = '[S]earch [G]it files' })
vim.keymap.set('n', '<leader>sf',
    function() require('utils.pretty-telescope').pretty_files_picker({ picker = "find_files" }) end,
    { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sm', ':Telescope noice<CR>',
    { desc = '[S]earch Notification [M]essages', noremap = true, silent = true })
vim.keymap.set('n', '<leader>sw', function()
    require("utils.pretty-telescope").pretty_grep_picker({ picker = "grep_string" })
end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>st',
    function() require("utils.pretty-telescope").pretty_grep_picker({ picker = "live_grep" }) end,
    { desc = '[S]earch by [T]ext' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr',
    function() require("utils.pretty-telescope").pretty_files_picker({ picker = "oldfiles" }) end,
    { desc = '[S]earch [R]ecently opened files' })
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').colorscheme,
    { desc = '[S]earch [C]olorscheme', noremap = true, silent = true })
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers,
    { desc = '[S]earch [B]uffers', noremap = true, silent = true })
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

vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { desc = 'Lazy[G]it' })

-- Harpoon
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "[A]ppend to harpoon" })
vim.keymap.set("n", "<leader><space>", function() harpoon_utils.toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Select harpoon window 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Select harpoon window 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Select harpoon window 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Select harpoon window 4" })
vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Select harpoon window 5" })
vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "Select harpoon window 6" })
vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { desc = "Select harpoon window 7" })
vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, { desc = "Select harpoon window 8" })
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, { desc = "Select harpoon window 9" })

-- Noice
vim.keymap.set("n", "<leader>nd", function() require("noice").cmd("dismiss") end, { desc = "[N]oice [D]ismiss" })
