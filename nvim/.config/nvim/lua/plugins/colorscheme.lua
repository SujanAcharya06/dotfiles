return {
  -- {
  --   'marko-cerovac/material.nvim',
  --   config = function()
  --     --Lua:
  --     vim.g.material_style = "deep ocean" -- {"deep ocean", "darker", "lighter"}
  --     --Lua:
  --     vim.cmd 'colorscheme material'
  --   end,
  -- },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "shaunsingh/nord.nvim",
    config = function()
      --Lua:
      vim.cmd[[colorscheme nord]]
      -- -- Example config in lua
      vim.g.nord_contrast = true
      vim.g.nord_borders = true 
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false

      -- Load the colorscheme
      require('nord').set()
    end,
  }
}
