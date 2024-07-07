return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        icons_enables = true;
        theme = 'gruvbox' --{dracula, gruvbox}
      }
    })
  end
}
