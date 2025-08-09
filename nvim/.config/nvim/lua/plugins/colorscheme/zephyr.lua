return {
    {
        "nvimdev/zephyr-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            -- Load the colorscheme
            require("zephyr")
            -- Or you can use: vim.cmd.colorscheme("zephyr")
        end,
    },
}
