return {
    -- Dashboard
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')
            dashboard.section.buttons.val = {
                dashboard.button("<C-n>", "󰈔  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("<C-p>", "󰱼  Find file",
                    ":lua require('utils.pretty-telescope').pretty_files_picker({ picker = 'find_files' })<CR>"),
                dashboard.button("<C-f>", "󰊄  Find text",
                    ":lua require('utils.pretty-telescope').pretty_grep_picker({ picker = 'live_grep' })<CR>"),
            }

            local function footer()
                local cmd = "bible-parser-xml-rust -f ~/nvi.min.xml random -v 5"
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
