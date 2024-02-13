---@diagnostic disable: missing-fields

return {
    {
        "folke/noice.nvim",
        priority = 100,
        event = "VeryLazy",
        opts = {
            routes = {
                {
                    view = "notify",
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    view = "notify",
                    filter = { event = "msg_showmode", find = "recording" },
                },
                {
                    filter = { event = "msg_show", find = "ago" },
                    opts = { skip = true },
                },
                {
                    filter = { event = "msg_show", find = "lines" },
                    opts = { skip = true },
                }
            },
            views = {
                cmdline_popup = {
                    border = {
                        style = "none",
                        padding = { 1, 2 },
                    },
                    filter_options = {},
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
            },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false,       -- add a border to hover docs and signature help
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                config = function()
                    local stages = require("notify.stages.slide")("top_down")

                    require("notify").setup({
                        background_colour = "NotifyBackground",
                        fps = 165,
                        icons = {
                            DEBUG = "",
                            ERROR = "",
                            INFO = "",
                            TRACE = "✎",
                            WARN = ""
                        },
                        level = 2,
                        minimum_width = 50,
                        render = "default",
                        stages = {
                            function(...)
                                local opts = stages[1](...)
                                if opts then
                                    opts.border = "none"
                                    opts.row = opts.row + 0.5
                                end
                                return opts
                            end,
                            unpack(stages, 2),
                        },
                        time_formats = {
                            notification = "%T",
                            notification_history = "%FT%T"
                        },
                        timeout = 5000,
                        top_down = true
                    }
                    )
                end
            },
        }
    },
}
