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

            -- Apply the colorscheme
            vim.cmd("colorscheme nightfox")
        end
    },
    {
        -- 'navarasu/onedark.nvim',
        -- priority = 1000,
        -- config = function()
        --     -- vim.cmd.colorscheme 'onedark'
        -- end,
    },
    {
        -- "catppuccin/nvim",
        -- name = "catppuccin",
        -- priority = 1000,
        -- config = function()
        --       vim.cmd.colorscheme("catppuccin")
        -- end,
    },
    {
        -- "folke/tokyonight.nvim",
        -- priority = 1000,
        -- config = function()
        --     local transparent = false -- set to true if you would like to enable transparency
        --
        --     local bg = "#011628"
        --     local bg_dark = "#011423"
        --     local bg_highlight = "#143652"
        --     local bg_search = "#0A64AC"
        --     local bg_visual = "#275378"
        --     local fg = "#CBE0F0"
        --     local fg_dark = "#B4D0E9"
        --     local fg_gutter = "#627E97"
        --     local border = "#547998"
        --
        --     require("tokyonight").setup({
        --         style = "night",
        --         transparent = transparent,
        --         styles = {
        --             sidebars = transparent and "transparent" or "dark",
        --             floats = transparent and "transparent" or "dark",
        --         },
        --         on_colors = function(colors)
        --             colors.bg = bg
        --             colors.bg_dark = transparent and colors.none or bg_dark
        --             colors.bg_float = transparent and colors.none or bg_dark
        --             colors.bg_highlight = bg_highlight
        --             colors.bg_popup = bg_dark
        --             colors.bg_search = bg_search
        --             colors.bg_sidebar = transparent and colors.none or bg_dark
        --             colors.bg_statusline = transparent and colors.none or bg_dark
        --             colors.bg_visual = bg_visual
        --             colors.border = border
        --             colors.fg = fg
        --             colors.fg_dark = fg_dark
        --             colors.fg_float = fg
        --             colors.fg_gutter = fg_gutter
        --             colors.fg_sidebar = fg_dark
        --         end,
        --     })
        --
        --     vim.cmd("colorscheme tokyonight")
        -- end,
    }

}
