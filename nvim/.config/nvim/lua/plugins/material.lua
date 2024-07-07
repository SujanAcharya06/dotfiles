return {
  'marko-cerovac/material.nvim',
  config = function()
    --Lua:
    vim.g.material_style = "deep ocean" -- {"deep ocean", "darker", "lighter"}
    --Lua:
    vim.cmd 'colorscheme material'
  end,
}
