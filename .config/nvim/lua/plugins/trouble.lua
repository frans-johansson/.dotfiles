-- Diagnostics window
return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local map = require("helpers.keys").map

			map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", "Toggle")
			map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics")
			map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", "Quickfix")
		end,
	},
}
