-- Miscelaneous fun stuff
return {
	-- Comment with haste
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- Align stuff
	{
		"echasnovski/mini.align",
		config = function()
			require("mini.align").setup()
		end,
	},
	-- Move stuff
	{
		"echasnovski/mini.move",
		config = function()
			require("mini.move").setup()
		end,
	},
	-- Better buffer closing actions. Available via the buffers helper.
	{
		"kazhala/close-buffers.nvim",
		opts = {
			preserve_window_layout = { "this", "nameless" },
		},
	},
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround stuff
}
