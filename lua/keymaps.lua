local togglers = require('utils.toggle')
-- local harpoon = require('harpoon')
local wk = require "which-key"

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

wk.register({
    ['<leader>'] = {
        name = 'VISUAL <leader>',
        T = {
            require('trouble').toggle,
            "[T] Trouble",
            noremap = true,
            silent = true
        },
        S = {
            require('spectre').open, '[S] Open Spectre', noremap = true, silent = true
        },
        t = {
            name = "Toggle",
            c = {
                require('copilot.suggestion').toggle_auto_trigger,
                "[C] Copilot",
                noremap = true,
                silent = true
            },
            s = { togglers.spaces_width, "[S] Tab size", noremap = true, silent = true },
            i = {
                togglers.tabs_spaces,
                "[I] Indentation (Tabs <-> Spaces)",
                noremap = true,
                silent = true
            },
            b = {
                require('gitsigns').toggle_current_line_blame,
                '[B] Blame current line',
                noremap = true,
                silent = true
            },
        },
        s = {
            name = "Search",
            s = {
                function()
                    require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))
                end,
                "[S] Spelling Suggestions",
                noremap = true,
                silent = true
            },
            ['?'] = {
                require('telescope.builtin').oldfiles, '[?] Recently opened files', noremap = true, silent = true
            },
            ['/'] = {
                function()
                    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes')
                        .get_dropdown())
                end,
                '[/] Fuzzy search current buffer',
                noremap = true,
                silent = true
            },
            -- g = {
            --     require('telescope.builtin').git_files, '[G] Git files', noremap = true, silent = true
            -- },
            f = {
                function() require('utils.pretty-telescope').pretty_files_picker({ picker = "find_files" }) end,
                '[F] Files in current directory',
                noremap = true,
                silent = true
            },
            -- m = {
            --     require('telescope').extensions.noice.noice, '[M] Notification Messages', noremap = true, silent = true
            -- },
            w = {
                function()
                    require("utils.pretty-telescope").pretty_grep_picker({ picker = "grep_string" })
                end,
                '[W] Current word under cursor',
                noremap = true,
                silent = true
            },
            g = {
                function() require("utils.pretty-telescope").pretty_grep_picker({ picker = "live_grep" }) end,
                '[G] Live Grep',
                noremap = true,
                silent = true
            },
            r = {
                function() require("utils.pretty-telescope").pretty_files_picker({ picker = "oldfiles", options = { only_cwd = true } }) end,
                '[R] Recently opened files',
                noremap = true,
                silent = true
            },
            b = {
                require('telescope.builtin').buffers, '[B] Buffers', noremap = true, silent = true
            },
            t = {
                "<cmd>TodoTrouble<cr>",
                '[T] Todos',
                noremap = true,
                silent = true
            }
        },
        d = {
            name = 'Diagnostics',
            f = {
                vim.diagnostic.open_float, '[F] Floating message', noremap = true, silent = true
            },
            l = {
                require('telescope.builtin').diagnostics, '[L] List', noremap = true, silent = true
            },
            s = {
                '<cmd>SymbolsOutline<cr>', '[S] Symbols', noremap = true, silent = true
            }
        },
        g = {
            name = "Git",
            b = {
                "<cmd>Git blame<cr>",
                '[G] Git blame',
                noremap = true,
                silent = true
            },
            l = {
                "<cmd>LazyGit<cr>",
                '[L] Lazy git',
                noremap = true,
                silent = true
            },
            p = {
                require('gitsigns').preview_hunk,
                '[P] Preview hunk',
                noremap = true,
                silent = true
            }
        },
        n = {
            name = "Noice",
            d = {
                function() require("noice").cmd("dismiss") end,
                "[D] Dismiss",
                noremap = true,
                silent = true
            }
        },
    }
}, { mode = { 'v', 'n' } })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

-- Split generation
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', { noremap = true, silent = true, desc = '[V] Vertical split' })
vim.keymap.set('n', '<leader>h', ':split<CR>', { noremap = true, silent = true, desc = '[H] Horizontal split' })

-- Re size split's
vim.keymap.set('n', '<C-up>', ':horizontal resize +3<CR>', { silent = true })
vim.keymap.set('n', '<C-down>', ':horizontal resize -3<CR>', { silent = true })
vim.keymap.set('n', '<C-left>', ':vertical resize +3<CR>', { silent = true })
vim.keymap.set('n', '<C-right>', ':vertical resize -3<CR>', { silent = true })

-- Move lines
vim.keymap.set('v', '<s-j>', ":m '>+1<CR>gv=gv", { silent = true, noremap = true, desc = 'Move line down' })
vim.keymap.set('v', '<s-k>', ":m '<-2<CR>gv=gv", { silent = true, noremap = true, desc = 'Move line up' })

-- Select all occurences of word under cursor
vim.cmd([[
    nmap <C-M-n> <Plug>(VM-Select-All)
    imap <C-M-n> <ESC><Plug>(VM-Select-All)
    vmap <C-M-n> <ESC><Plug>(VM-Select-All)
]])

-- Scrolling remaps to
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep selection when indenting multiple lines
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Open Alpha dashboard
vim.keymap.set('n', '<leader>;', '<cmd>Alpha<cr>', { noremap = true, silent = true, desc = "[;] Dashboard" })

-- Open explorer
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = '[E] Explorer', silent = true, noremap = true })

-- don't override the built-in and fugitive keymaps
local gs = package.loaded.gitsigns
vim.keymap.set({ 'n', 'v' }, ']h', function()
    if vim.wo.diff then return ']h' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
end, { expr = true, desc = "Jump to next hunk" })
vim.keymap.set({ 'n', 'v' }, '[h', function()
    if vim.wo.diff then return '[h' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
end, { expr = true, desc = "Jump to previous hunk" })

-- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<leader><space>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
-- vim.keymap.set("n", "<leader><space>", function() require("utils.harpoon").toggle_telescope(harpoon:list()) end)
-- vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
-- vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end)
-- vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end)
-- vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end)
-- vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end)
-- vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end)

vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<cr>')
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<cr>')
vim.keymap.set('n', '<leader>q', '<Cmd>BufferClose<cr>')

-- Vim Visual Multi disable backspace mapping to avoid conflict with autopairs
vim.g.VM_maps = {
    ["I BS"] = '',
}

-- dismiss copilot suggestion
vim.keymap.set('i', '<C-d>', function()
    require("copilot.suggestion").dismiss()
end, { noremap = true, silent = true })

-- ESC to dismiss search highlights
vim.keymap.set('n', '<Esc>', '<Cmd>noh<cr>', { noremap = true, silent = true })
