return {
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        event = { 'BufReadPost' },
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',

            -- None-ls for code actions, diagnostics & formatting
            'nvimtools/none-ls.nvim',
        },
        config = function()
            local null_ls = require('null-ls')

            -- Setup neovim lua configuration
            require('neodev').setup()

            require("mason").setup({})

            -- [[ Configure LSP ]]
            --  This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(client, bufnr)
                local wk = require "which-key"

                local lsp_map = function(keys, func, desc)
                    wk.register({
                        ['<leader>'] = {
                            l = {
                                name = 'LSP',
                                [keys] = { func, desc, { buffer = bufnr } }
                            }
                        }
                    }, { mode = { 'n', 'v' } })
                end

                local workspace_map = function(keys, func, desc)
                    wk.register({
                        ['<leader>'] = {
                            w = {
                                name = 'Workspace',
                                [keys] = { func, desc, { buffer = bufnr } }
                            }
                        }
                    }, { mode = { 'n', 'v' } })
                end

                local function restart()
                    vim.cmd('LspRestart')
                end

                -- Basic keymaps for LSP
                vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                    { desc = 'Hover Documentation', noremap = true, silent = true })
                vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_type_definitions,
                    { desc = 'Goto Type Definition', noremap = true, silent = true })
                vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions,
                    { desc = 'Goto Definition', noremap = true, silent = true })
                vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations,
                    { desc = 'Goto Implementation', noremap = true, silent = true })
                vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references,
                    { desc = 'Goto References', noremap = true, silent = true })

                lsp_map('s', vim.lsp.buf.signature_help, '[S] Signature Documentation')
                lsp_map('r', vim.lsp.buf.rename, '[R] Rename')
                lsp_map('a', vim.lsp.buf.code_action, '[A] Code actions')
                lsp_map('f', vim.lsp.buf.format, '[F] Format current file')
                lsp_map('R', restart, '[R] Restart server')

                workspace_map('a', vim.lsp.buf.add_workspace_folder, '[A] Workspace add folder')
                workspace_map('r', vim.lsp.buf.remove_workspace_folder, '[R] Workspace remove folder')
                workspace_map('l', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[L] Workspace list folders')
                workspace_map('s', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S] Workspace symbols')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format({
                        filter = function(format_client)
                            -- Use Prettier to format JS/TS if available
                            return format_client.name ~= 'tsserver' or not null_ls.is_registered('prettier')
                        end
                    })
                end, { desc = 'Format current buffer with LSP' })

                if client.name == 'v_analyzer' then
                    wk.register({
                        ['<leader>'] = {
                            s = {
                                v = {
                                    name = 'Vlang',
                                    f = {
                                        function()
                                            require 'telescope.builtin'.find_files {
                                                cwd = vim.fn.expand '$HOME' .. '/.vmodules'
                                            }
                                        end,
                                        '[F] Find files in V modules',
                                        { buffer = bufnr, noremap = true, silent = true },
                                    },
                                    g = { function()
                                        require 'telescope.builtin'.live_grep {
                                            cwd = vim.fn.expand '$HOME' .. '/.vmodules'
                                        }
                                    end, '[G] Live grep in V modules',
                                        { buffer = bufnr, noremap = true, silent = true },
                                    }
                                }
                            }
                        }
                    })
                end
            end

            -- Enable the following language servers
            --  If you want to override the default filetypes that your language server will attach to you can
            --  define the property 'filetypes' to the map in question.
            local servers = {
                gopls = {},
                pyright = {},
                rust_analyzer = {},
                v_analyzer = { filetypes = { 'vlang', 'vsh' } },
                tsserver = {
                    settings = {
                        experimental = {
                            enableProjectDiagnostics = true,
                        },
                    },
                },
                tailwindcss = {},
                prismals = {},
                sqlls = {
                    cmd = { "sql-language-server", "up", "--method", "stdio" },
                    filetypes = { "sql", "mysql" },
                    root_dir = function()
                        return vim.loop.cwd()
                    end
                },
                html = { filetypes = { 'html', 'twig', 'hbs' } },
                jsonls = {},
                lua_ls = {
                    cmd = { 'lua-language-server --silent' },
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            }

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            mason_lspconfig.setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = servers[server_name],
                        filetypes = (servers[server_name] or {}).filetypes,
                    }
                end
            }

            local formatting = null_ls.builtins.formatting

            null_ls.setup({
                sources = {
                    formatting.prettierd,
                    formatting.sql_formatter
                }
            })

            -- Make sure that .v files are treated as vlang
            vim.filetype.add({
                extension = {
                    v = 'vlang',
                    vsh = 'vlang'
                },
            })

            vim.diagnostic.config({})
        end,
    },
}
