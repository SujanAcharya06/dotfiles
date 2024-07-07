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
        -- ensure_installed = { "lua_ls", "clangd", "pylsp" }
        auto_install = true,
      })
    end
  },
  -- For more customization use :h vim.lsp.buf
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")

      -- for lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- Setup for clangd
      lspconfig.clangd.setup({
        capabilities = capabilities,
        filetypes = { "c", "objc",} -- {"cpp", "objcpp"}
      })

      -- Setup for pylsp
      lspconfig.pylsp.setup({
        capabilities = capabilities,
      })

      --Setup for html
      lspconfig.html.setup({
        capabilities = capabilities,
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
