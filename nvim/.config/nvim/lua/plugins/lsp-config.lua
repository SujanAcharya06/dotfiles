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
        ensure_installed = { "lua_ls", "clangd" }
      })
    end
  },
  -- For more customization use :h vim.lsp.buf
  {
    "neovim/nvim-lspconfig",
    config = function()

      local lspconfig = require("lspconfig")

      --for lua
      lspconfig.lua_ls.setup({})

      -- Setup for clangd
      lspconfig.clangd.setup({
        filetypes = { "c", "objc",}, -- {"cpp", "objcpp"}
        cmd = { "clangd", "--background-index" },
        init_options = {
          compilationDatabaseDirectory = ".",
          clangd = {
            extraArgs = {
              "-std=c++11",
              "/usr/include/c++/11",
              -- Add any other necessary flags or include paths here
            }
          }
        }
      })
      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
