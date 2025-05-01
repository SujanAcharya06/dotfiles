-- File: ~/.config/nvim/lua/plugins/java.lua

return {
    -- Core Java LSP support
    {
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        config = function()
            local jdtls_setup = function()
                local jdtls = require("jdtls")

                -- Find project root
                local root_dir = require("jdtls.setup").find_root({"pom.xml", "build.gradle", ".git"})
                if root_dir == nil then
                    root_dir = vim.fn.getcwd()
                end

                -- Set up workspace folder
                local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
                local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name
                vim.fn.mkdir(workspace_dir, "p")

                -- Get jdtls installation path from Mason
                local mason_registry = require("mason-registry")
                local jdtls_pkg = mason_registry.get_package("jdtls")
                local jdtls_path = jdtls_pkg:get_install_path()

                -- Find the launcher jar (fixed path handling)
                local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
                if launcher_jar == "" then
                    vim.notify("Could not find eclipse launcher jar. Make sure jdtls is installed correctly.", vim.log.levels.ERROR)
                    return
                end

                -- Determine OS for config folder
                local config_dir
                if vim.fn.has("mac") == 1 then
                    config_dir = jdtls_path .. "/config_mac"
                elseif vim.fn.has("win32") == 1 then
                    config_dir = jdtls_path .. "/config_win"
                else
                    config_dir = jdtls_path .. "/config_linux"
                end

                -- Verify config dir exists
                if vim.fn.isdirectory(config_dir) == 0 then
                    vim.notify("JDTLS config directory not found: " .. config_dir, vim.log.levels.ERROR)
                    return
                end

                -- Debug output
                vim.notify("JDTLS Path: " .. jdtls_path, vim.log.levels.INFO)
                vim.notify("Launcher JAR: " .. launcher_jar, vim.log.levels.INFO)
                vim.notify("Config Dir: " .. config_dir, vim.log.levels.INFO)

                -- Configure jdtls
                local config = {
                    cmd = {
                        "java",
                        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                        "-Dosgi.bundles.defaultStartLevel=4",
                        "-Declipse.product=org.eclipse.jdt.ls.core.product",
                        "-Dlog.protocol=true",
                        "-Dlog.level=ALL",
                        "-Xms1g",
                        "--add-modules=ALL-SYSTEM",
                        "--add-opens", "java.base/java.util=ALL-UNNAMED",
                        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
                        "-jar", launcher_jar,
                        "-configuration", config_dir,
                        "-data", workspace_dir,
                    },
                    root_dir = root_dir,

                    -- Your on_attach function from lsp-config.lua
                    on_attach = function(client, bufnr)
                        vim.notify("Java LSP attached successfully", vim.log.levels.INFO)

                        -- Add a single code action keymap that shows all available actions
                        local opts = { buffer = bufnr, noremap = true, silent = true }
                        vim.keymap.set("n", "<leader>ja", function()
                            vim.lsp.buf.code_action({
                                -- Filter to keep only jdtls code actions
                                filter = function(action)
                                    return action.title ~= nil
                                end,
                                -- Show code actions in a nice menu
                                apply = true,
                            })
                        end, { buffer = bufnr, desc = "Java Code Actions" })

                        -- Keep individual keymaps for direct access to specific functions
                        vim.keymap.set("n", "<leader>ji", jdtls.organize_imports, opts)
                        vim.keymap.set("n", "<leader>jv", function() jdtls.extract_variable(true) end, opts)
                        vim.keymap.set("n", "<leader>jc", function() jdtls.extract_constant(true) end, opts)
                        vim.keymap.set("n", "<leader>jm", function() jdtls.extract_method(true) end, opts)

                        -- Standard LSP bindings
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    end,

                    capabilities = require('cmp_nvim_lsp').default_capabilities(),

                    settings = {
                        java = {
                            signatureHelp = { enabled = true },
                            contentProvider = { preferred = 'fernflower' },
                            completion = {
                                favoriteStaticMembers = {
                                    "org.junit.Assert.*",
                                    "org.junit.jupiter.api.Assertions.*",
                                    "java.util.Objects.requireNonNull",
                                },
                            },
                            sources = {
                                organizeImports = {
                                    starThreshold = 9999,
                                    staticStarThreshold = 9999,
                                },
                            },
                            codeGeneration = {
                                toString = {
                                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                                },
                                hashCodeEquals = {
                                    useJava7Objects = true,
                                },
                                useBlocks = true,
                            },
                        },
                    },
                }

                -- Start jdtls
                jdtls.start_or_attach(config)
            end

            -- Setup jdtls when opening a Java file
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "java",
                callback = jdtls_setup,
            })
        end,
    },
}
