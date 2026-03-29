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
                ensure_installed = { "lua_ls", "clangd", "html", "pyright", "cssls", "bashls"},
                automatic_installation = false -- stop auto-start for installed servers
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
                -- Skip notification for Java files since nvim-jdtls handles them
                if vim.bo[bufnr].filetype ~= "java" then
                    notify("LSP attached: " .. client.name, "info", {
                        title = "Language Server Protocol",
                        timeout = 1000,
                    })
                end
                -- Enable signature help
                if client.server_capabilities.signatureHelpProvider then
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
                end
                -- Mappings.
                local opts = { buffer = bufnr, noremap = true, silent = true }
                -- ... (keep existing keymaps)
            end

            -- COMPLETELY DISABLE automatic jdtls configuration
            -- Override the jdtls config to prevent auto-setup
            lspconfig.configs.jdtls = nil
            lspconfig.jdtls = nil

            -- Also disable it at the filetype level
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = function()
                    -- Stop any jdtls that might be auto-starting
                    for _, client in pairs(vim.lsp.get_active_clients({ name = "jdtls" })) do
                        if client.config.cmd and client.config.cmd[1] == "jdtls" then
                            -- This is the basic jdtls, stop it
                            vim.lsp.stop_client(client.id)
                        end
                    end
                end,
            })

            -- Setup function for LSP servers
            local setup_server = function(server, config)
                -- Skip Java LSP because it's handled separately in java.lua via nvim-jdtls
                if server == "jdtls" then
                    return
                end
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
