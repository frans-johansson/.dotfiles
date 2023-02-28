-- LSP Configuration & Plugins
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'j-hui/fidget.nvim',
            'folke/neodev.nvim',
            'RRethy/vim-illuminate',
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            -- Neodev setup before LSP config
            require("neodev").setup()

            -- Turn on LSP status information
            require('fidget').setup()

            -- Set up cool signs for diagnostics
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Diagnostic config
            local config = {
                virtual_text = false,
                signs = {
                    active = signs,
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }
            vim.diagnostic.config(config)

            -- This function gets run when an LSP connects to a particular buffer.
            local on_attach = function(client, bufnr)
                local lsp_map = require('helpers.keys').lsp_map

                lsp_map('<leader>rn', vim.lsp.buf.rename, bufnr, '[R]e[n]ame')
                lsp_map('<leader>ca', vim.lsp.buf.code_action, bufnr, '[C]ode [A]ction')

                lsp_map('gd', vim.lsp.buf.definition, bufnr, '[G]oto [D]efinition')
                lsp_map('gr', require('telescope.builtin').lsp_references, bufnr, '[G]oto [R]eferences')
                lsp_map('gI', vim.lsp.buf.implementation, bufnr, '[G]oto [I]mplementation')
                lsp_map('<leader>D', vim.lsp.buf.type_definition, bufnr, 'Type [D]efinition')
                lsp_map('<leader>ds', require('telescope.builtin').lsp_document_symbols, bufnr, '[D]ocument [S]ymbols')
                lsp_map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, bufnr,
                    '[W]orkspace [S]ymbols')
                lsp_map('K', vim.lsp.buf.hover, bufnr, 'Hover Documentation')

                -- Lesser used LSP functionality
                lsp_map('gD', vim.lsp.buf.declaration, bufnr, '[G]oto [D]eclaration')
                lsp_map('<leader>wa', vim.lsp.buf.add_workspace_folder, bufnr, '[W]orkspace [A]dd Folder')
                lsp_map('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufnr, '[W]orkspace [R]emove Folder')
                lsp_map('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, bufnr, '[W]orkspace [L]ist Folders')

                -- Create a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })

                lsp_map('<leader>fd', '<cmd>Format<cr>', bufnr, '[F]ormat [D]ocument')

                -- Attach and configure vim-illuminate
                require('illuminate').on_attach(client)
            end

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Lua
            require('lspconfig')['lua_ls'].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace"
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                }
            }

            -- Python
            require('lspconfig')['pylsp'].setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            flake8 = {
                                enabled = true,
                                maxLineLength = 88  -- Black's line length
                            },
                            -- Disable plugins overlapping with flake8
                            pycodestyle = {
                                enabled = false
                            },
                            mccabe = {
                                enabled = false
                            },
                            pyflakes = {
                                enabled = false
                            },
                            -- Use Black as the formatter
                            autopep8 = {
                                enabled = false
                            }
                        }
                    }
                }
            }
        end
    }
}
