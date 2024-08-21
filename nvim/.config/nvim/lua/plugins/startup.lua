return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
        theme = "doom",
        config = {
            header = {
                "                                   ",
                "                                   ",
                "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
                "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
                "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
                "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
                "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
                "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
                "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
                " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
                " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
                "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
                "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
                "                                   ",
            },
            center = {
                {
                    icon = " ",
                    icon_hl = "Title",
                    desc = "Find File",
                    desc_hl = "String",
                    key = "f",
                    keymap = "SPC f f",
                    key_hl = "Number",
                    action = "Telescope find_files"
                },
                {
                    icon = " ",
                    desc = "Recent Files",
                    key = "r",
                    keymap = "SPC f r",
                    action = "Telescope oldfiles"
                },
                {
                    icon = " ",
                    desc = "New File",
                    key = "n",
                    keymap = "SPC c n",
                    action = "enew"
                },
                {
                    icon = " ",
                    desc = "Quit Neovim",
                    key = "q",
                    keymap = "SPC q",
                    action = "qa"
                },
            },
            disable_move,
            footer = {"🚀 Day-1"}
        }
    },
    dependencies = { {'nvim-tree/nvim-web-devicons'} }
}
