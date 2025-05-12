-- ~/.config/nvim/lua/plugins/java.lua
return {
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        config = function()
            local notify = require("notify")
            local jdtls = require("jdtls")
            local home = os.getenv("HOME")
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local config = {
                cmd = {
                    "jdtls",
                    "--jvm-arg=-javaagent:" .. home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar"
                },
                root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
                capabilities = capabilities,
                settings = {
                    java = {
                        configuration = {
                            updateBuildConfiguration = "interactive",
                        },
                        maven = {
                            downloadSources = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        format = {
                            enabled = true,
                        },
                    },
                },
                init_options = {
                    bundles = {},
                },
                on_attach = function(client, bufnr)
                    notify("Java LSP attached: " .. client.name, "info", {
                        title = "nvim-jdtls",
                        timeout = 1000,
                    })

                    local opts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    -- optional: refresh code lenses
                end,
            }

            jdtls.start_or_attach(config)
        end,
    },
}

