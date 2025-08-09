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
                    "/usr/lib/jvm/jdk-21.0.7-oracle-x64/bin/java",
                    "-javaagent:" .. home .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.level=ALL",
                    "-noverify",
                    "-Xmx1G",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens", "java.base/java.util=ALL-UNNAMED",
                    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                    "-jar", vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
                    "-configuration", home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
                    "-data", workspace_dir,
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
                    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<leader>ja", vim.lsp.buf.code_action, { noremap = true, silent = true })
                    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                    -- optional: refresh code lenses
                end,
            }

            jdtls.start_or_attach(config)
        end,
    },
}

