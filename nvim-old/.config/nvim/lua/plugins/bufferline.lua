return{
    {'akinsho/bufferline.nvim',
        version = "*",
        dependencies = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require("bufferline").setup{}
            vim.keymap.set({'n'}, '<space>xx', ':BufferLineCloseOthers<CR>',{})
            vim.keymap.set({'n'}, '<C-h>', ':BufferLineCyclePrev<CR>',{})
            vim.keymap.set({'n'}, '<C-l>', ':BufferLineCycleNext<CR>',{})
            vim.keymap.set({'n'}, '<space>hx', ':BufferLineCloseLeft<CR>',{})
            vim.keymap.set({'n'}, '<space>hx', ':BufferLineCloseLeft<CR>',{})
            vim.keymap.set({'n'}, '<space>lx', ':BufferLineCloseRight<CR>',{})
        end,
    }
}

