-- Miscelaneous fun stuff
return {
	-- Comment with haste
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	-- Align stuff with <ga>
	{
		"echasnovski/mini.align",
		config = function()
			require("mini.align").setup()
		end,
	},
	-- Move stuff with <M-j> and <M-k> in both normal and visual mode
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
	-- Integration with TMUX for smarter navigation
	{
		"christoomey/vim-tmux-navigator",
		config = function()
			-- Save all buffers on navigation
			vim.g.tmux_navigator_save_on_switch = 2
			-- If the tmux window is zoomed, keep it zoomed when moving from Vim to another pane
			vim.g.tmux_navigator_preserve_zoom = 1
		end,
	},
	-- Show a file outline powered by LSP
	{
		"simrat39/symbols-outline.nvim",
		config = function ()
			require("symbols-outline").setup()
			local map = require("helpers.keys").map
			map("n", "<leader>us", "<cmd>SymbolsOutline<cr>", "Toggle symbols outline")
		end
	},
	"typicode/bg.nvim", -- Have the terminal background match the colorscheme
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands
}
