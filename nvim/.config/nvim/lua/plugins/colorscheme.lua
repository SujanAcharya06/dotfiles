return{
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      -- vim.g.material_style = "deep ocean"
      -- vim.cmd('colorscheme material')
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
    --   vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "shaunsingh/nord.nvim",
    config = function()
      -- vim.g.nord_contrast = true
      -- vim.g.nord_borders = true
      -- vim.g.nord_disable_background = false
      -- vim.g.nord_italic = false
      -- vim.g.nord_uniform_diff_background = true
      -- vim.g.nord_bold = false
      -- require('nord').set()
    end
  }
}
