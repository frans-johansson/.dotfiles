-- Miscelaneous fun stuff
return {
    -- Comment with haste
    { 'numToStr/Comment.nvim',
        config = {}
    },
    -- Align stuff
    {
        'echasnovski/mini.align',
        config = function()
            require('mini.align').setup()
        end
    },
    -- Move stuff
    {
        'echasnovski/mini.move',
        config = function()
            require('mini.move').setup()
        end
    },
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    'tpope/vim-surround', -- Surround stuff
}
