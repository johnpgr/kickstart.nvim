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

            require("mason").setup({
                ui = { border = "rounded" },
            })

            -- [[ Configure LSP ]]
            --  This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(_, bufnr)
                -- NOTE: Remember that lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself
                -- many times.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end

                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                end

                nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
                nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
                nmap('gD', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
                nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
                nmap('<f2>', vim.lsp.buf.rename, 'LSP: Rename')
                nmap('<leader>la', vim.lsp.buf.code_action, '[L]SP Code [A]ctions')
                nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
                nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

                -- See `:help K` for why this keymap
                nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
                nmap('<leader>ls', vim.lsp.buf.signature_help, '[L]SP [S]ignature Documentation')

                -- Lesser used LSP functionality
                nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, '[W]orkspace [L]ist Folders')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format({
                        filter = function(format_client)
                            -- Use Prettier to format JS/TS if available
                            return format_client.name ~= 'tsserver' or not null_ls.is_registered('prettier')
                        end
                    })
                end, { desc = 'Format current buffer with LSP' })

                nmap('<leader>lf', vim.lsp.buf.format, '[L]SP [F]ormat current file')
                nmap('<leader>lr', ':LspRestart<CR>', '[L]SP [R]estart server')
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
                sqlls = {},
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
                border = "rounded",
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

            vim.diagnostic.config({
                float = {
                    border = "rounded"
                }
            })
        end,
    },
}
