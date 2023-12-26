-- [[ Basic Keymaps ]]

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
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = '[E]xplorer', silent = true })

-- Change colorscheme
vim.keymap.set('n', '<leader>cc', require('telescope.builtin').colorscheme,
    { desc = '[C]hange [C]olorscheme', noremap = true, silent = true })

-- Search notification history
vim.keymap.set('n', '<leader>sh', ':Telescope noice<CR>',
    { desc = '[S]earch notification [H]istory', noremap = true, silent = true })

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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Open [D]iagnostic [F]loating message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist' })

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


local function toggle_tabs_and_spaces()
    -- Get the current buffer number
    local bufnr = vim.fn.bufnr()

    -- Get the current value of 'expandtab' (whether spaces are being used)
    local expandtab = vim.bo.expandtab

    if expandtab then
        -- If spaces are being used, toggle to tabs
        vim.bo.expandtab = false
    else
        -- If tabs are being used, toggle to spaces
        vim.bo.expandtab = true
    end

    -- Get the updated values of 'tabstop' and 'shiftwidth' after toggling
    local tabstop = vim.bo.tabstop
    local shiftwidth = vim.bo.shiftwidth

    -- Retab the buffer to apply the changes
    vim.fn.execute('retab!')

    -- Display a message indicating the toggle is done
    local current_mode = vim.bo.expandtab == true and "Spaces" or "Tabs"
    print("Current indentation mode: " .. current_mode)
end

vim.keymap.set('n', '<leader>ts', toggle_spaces_width, { desc = "Toggle Tab size", noremap = true, silent = true })
vim.keymap.set('n', '<leader>ti', toggle_tabs_and_spaces,
    { desc = "Toggle indentation mode (Tabs <-> Spaces)", noremap = true, silent = true })

-- Persistence
vim.keymap.set('n', '<leader>pc', "<cmd>lua require('persistence').load()<cr>",
    { desc = 'Restore last session for cwd', silent = true })
vim.keymap.set('n', '<leader>pl', "<cmd>lua require('persistence').load({ last = true })<cr>", {
    desc = 'Restore last session', silent = true
})
vim.keymap.set('n', '<leader>pQ', "<cmd>lua require('persistence').stop()<cr>", {
    desc = 'Quit without saving session', silent = true
})

vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'Open Lazygit' })

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
vim.keymap.set('n', '<leader>q', ':BufferClose<CR>', { desc = 'Close current buffer', noremap = true, silent = true })
vim.keymap.set('n', '<leader>Q', ':BufferCloseAllButCurrentOrPinned<CR>',
    { desc = 'Close all other buffers', noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', ':enew<CR>', { desc = 'New buffer', noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', ':BufferMoveNext<CR>',
    { desc = 'Move buffer to next position', noremap = true, silent = true })
vim.keymap.set('n', '<A-h>', ':BufferMovePrevious<CR>',
    { desc = 'Move buffer to previous position', noremap = true, silent = true })
