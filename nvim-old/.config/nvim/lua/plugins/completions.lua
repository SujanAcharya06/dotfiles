return{
    {
        "hrsh7th/cmp-nvim-lsp"
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None',
                        col_offset = 0,
                        side_padding = 1,
                        scrollbar = false,
                    },
                    documentation = {
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None',
                    },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(entry, vim_item)
                            vim_item.menu = ({
                                nvim_lsp = "[LSP]",
                                luasnip = "[Snippet]",
                                buffer = "[Buffer]",
                                path = "[Path]",
                                omni = "[Omni]",
                                ["vim-dadbod-completion"] = "[DB]",
                            })[entry.source.name]

                            return vim_item
                        end
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip", priority = 750 },
                    { name = "path", priority = 500 },
                    { name = 'omni', priority = 400 },
                    { name = "buffer", priority = 250, keyword_length = 2 },
                    { name = 'vim-dadbod-completion', priority = 250 },
                }),
                experimental = {
                    ghost_text = true,
                },
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' }
                    })
            })
        end,
    },
}
