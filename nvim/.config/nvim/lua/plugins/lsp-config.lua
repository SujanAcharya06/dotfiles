return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "html", "pyright", "cssls", "bashls"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local notify = require("notify")
            notify.setup({
                top_down = false
            })
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            local lspconfig = require("lspconfig")
            local on_attach = function(client, bufnr)
                notify("LSP attached: " .. client.name, "info", {
                    title = "Language Server Protocol",
                    timeout = 1000,
                })
                -- Enable signature help
                if client.server_capabilities.signatureHelpProvider then
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
                end
                -- Mappings.
                local opts = { buffer = bufnr, noremap = true, silent = true }
                -- ... (keep existing keymaps)
            end

            -- Setup function for LSP servers
            local setup_server = function(server, config)
                config = config or {}
                config.capabilities = capabilities
                config.on_attach = on_attach
                config.root_dir = function(fname)
                    return vim.fn.getcwd()
                end
                lspconfig[server].setup(config)
            end

            -- Setup servers
            setup_server("lua_ls")
            setup_server("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                    "--header-insertion=iwyu",
                    "--suggest-missing-includes",
                    "--all-scopes-completion"
                },
                filetypes = { "c", "objc"}, -- { "cpp", "objcpp" }
                init_options = {
                    clangdFileStatus = true,
                    usePlaceholders = true,
                    completeUnimported = true,
                    semanticHighlighting = true
                },
            })

            setup_server("pyright", {
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                            includeAuthorityInWorkspaceSymbolsResponse = true,
                        }
                    }
                }
            })
            -- HTML LSP setup
            setup_server("html", {
                filetypes = { "html" },
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true,
                    },
                }
            })
            -- Bash LSP setup
            setup_server("bashls")

            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = false,
            })
            vim.g.lsp_semantic_enabled = 1

            -- vim.o.updatetime = 250 -- Set a lower updatetime for better responsiveness
            -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.hover()]]
        end
    }
}
