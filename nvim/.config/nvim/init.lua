-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- init.lua
require("ftoptions.java-launch")
-- require("ftoptions.cpp-proj")
require("ftoptions.cpp-cmake-proj")

vim.cmd.colorscheme("onedark_vivid")
