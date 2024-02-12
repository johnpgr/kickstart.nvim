return {
    -- Dashboard
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')
            dashboard.section.buttons.val = {
                dashboard.button("n", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "󰱼  Find file",
                    ":lua require('utils.pretty-telescope').pretty_files_picker({ picker = 'find_files' })<CR>"),
                dashboard.button("r", "󰄉  Recently used files",
                    ":lua require('utils.pretty-telescope').pretty_files_picker({ picker = 'oldfiles', options = {only_cwd = true} })<CR>"),
                dashboard.button("t", "󰊄  Find text",
                    ":lua require('utils.pretty-telescope').pretty_grep_picker({ picker = 'live_grep' })<CR>"),
                dashboard.button("g", "  Lazygit", ":LazyGit<CR>"),
                dashboard.button("l", "󰭖  Load last session for cwd", ":lua require('persistence').load()<CR>"),
                dashboard.button("c", "  Configuration", ":cd ~/.config/nvim | :e init.lua<CR>"),
                dashboard.button("q", "󰅚  Quit Neovim", ":qa<CR>"),
            }

            local function footer()
                local cmd = "~/.local/bin/bible-parser-xml-rust -f ~/nvi.min.xml random"
                local handle = io.popen(cmd)

                if handle then
                    local result = handle:read("*a") or ""
                    handle:close()
                    return result
                else
                    print("Error running command: " .. cmd)
                end

                return "Unable to get Bible verse"
            end

            dashboard.section.footer.val = footer()

            dashboard.section.footer.opts.hl = "Type"
            dashboard.section.header.opts.hl = "Include"
            dashboard.section.buttons.opts.hl = "Keyword"
            dashboard.opts.opts.noautocmd = true
            alpha.setup(dashboard.opts)
        end
    }
}
