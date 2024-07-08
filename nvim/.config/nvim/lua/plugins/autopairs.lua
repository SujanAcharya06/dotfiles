return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require('nvim-autopairs.rule')

      npairs.setup({})

      -- Variable to track the state of autopairs
      local autopairs_enabled = true

      -- Function to toggle autopairs
      local function toggle_autopairs()
        autopairs_enabled = not autopairs_enabled
        if autopairs_enabled then
          npairs.enable()
          print("Autopairs enabled")
        else
          npairs.disable()
          print("Autopairs disabled")
        end
      end

      -- Set up the keybinding to toggle autopairs
      vim.api.nvim_set_keymap('n', '<C-i>', ':lua require("nvim-autopairs").toggle()<CR>', {noremap = true, silent = true})

      -- Override the toggle function of nvim-autopairs
      npairs.toggle = toggle_autopairs
    end
  }
}
