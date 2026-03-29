return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        ignored_next_char = "[%w%.]",
        enable_afterquote = true,  -- add bracket pairs after quote
        enable_check_bracket_line = true,  -- check bracket in same line
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

        -- Add space rules
        local Rule = require('nvim-autopairs.rule')
        local cond = require('nvim-autopairs.conds')

        -- Add spaces between parentheses
        npairs.add_rules({
            Rule(' ', ' ')
                :with_pair(function(opts)
                    local pair = opts.line:sub(opts.col - 1, opts.col)
                    return vim.tbl_contains({ '()', '[]', '{}' }, pair)
                end),
            Rule('( ', ' )')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%)') ~= nil
                end)
                :use_key(')'),
            Rule('{ ', ' }')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%}') ~= nil
                end)
                :use_key('}'),
            Rule('[ ', ' ]')
                :with_pair(function() return false end)
                :with_move(function(opts)
                    return opts.prev_char:match('.%]') ~= nil
                end)
                :use_key(']')
        })
    end,
}
