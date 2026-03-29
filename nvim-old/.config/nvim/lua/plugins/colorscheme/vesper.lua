return {
  {
    "datsfilipe/vesper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load the colorscheme
      vim.cmd.colorscheme("vesper")
    end,
  },
}
