return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        ignored_next_char = "[%w%.]",
        fast_wrap = {
            map = "<C-w>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    },
    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)

        local Rule = require("nvim-autopairs.rule")
        -- npairs.add_rule(Rule("<", ">"))
    end,
}
