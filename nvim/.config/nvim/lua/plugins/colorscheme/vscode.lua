return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optional: Configure vscode.nvim settings
      require("vscode").setup({
        -- Alternatively set style in setup
        -- style = 'dark' -- or 'light'

        -- Enable transparent background
        transparent = false,

        -- Enable italic comment
        italic_comments = true,

        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,
      })
    end,
  },
}
