return{
    {
        "EdenEast/nightfox.nvim",
        config = function()
            -- Configure nightfox.nvim
            require('nightfox').setup({
                options = {
                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        types = "italic,bold",
                    },
                    -- Enable terminal colors
                    terminal_colors = true,

                    sidebars = { "qf", "vista_kind", "terminal", "packer" },
                    float = { "popup", "hover" },

                    -- Use transparent background
                    transparent = false,

                    -- Additional colors for 'nightfox' theme
                    colors = {
                        bg = "#282c34",
                        fg = "#abb2bf",
                    },

                    -- Override default colors for specific groups
                    overrides = {
                        Normal = { bg = "#282c34", fg = "#abb2bf" },
                        Comment = { fg = "#5c6370", style = "italic" },
                        Function = { fg = "#61afef", style = "bold" },
                        Keyword = { fg = "#c678dd", style = "bold" },
                        String = { fg = "#98c379" },
                    },
                },
            })

            vim.cmd("colorscheme carbonfox")
        end
    },
}
