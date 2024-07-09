return {
  {
    'marko-cerovac/material.nvim',
    config = function()
    --   --Lua:
    --   vim.g.material_style = "deep ocean" -- {"deep ocean", "darker", "lighter"}
    --   --Lua:
    --   vim.cmd 'colorscheme material'
    end,
  },
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
    conifig = function()
      vim.cmd.colorscheme('nord')
    end,
  }
}
