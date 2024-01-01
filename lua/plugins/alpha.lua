return {
    -- Dashboard
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')
            dashboard.section.buttons.val = {
                dashboard.button("n", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
                dashboard.button("r", "󰄉  Recently used files", ":Telescope oldfiles cwd_only=true <CR>"),
                dashboard.button("t", "󰊄  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("g", "  Lazygit", ":LazyGit<CR>"),
                dashboard.button("l", "󰭖  Load last session for cwd", ":lua require('persistence').load()<CR>"),
                dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
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
