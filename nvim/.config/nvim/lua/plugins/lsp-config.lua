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
        ensure_installed = { "lua_ls", "clangd", "pyright", "jdtls" }
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
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        notify("LSP attached: " .. client.name, "info", {
          title = "Language Server Protocol",
          timeout = 1000,
        })

        -- Your existing keymaps...
      end

      -- Setup function for LSP servers
      local setup_server = function(server, config)
        config = config or {}
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server].setup(config)
      end

      -- Setup servers
      setup_server("lua_ls")
      setup_server("clangd", {
        filetypes = { "c", "objc" } -- {"cpp", "objcpp"}
      })
      setup_server("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace"
            }
          }
        }
      })
      setup_server("html")
      setup_server("jdtls")

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false,
      })

      -- You can keep your existing global keymaps here if needed
    end
  }
}
