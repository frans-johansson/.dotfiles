-- Diagnostics window
return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local map = require("helpers.keys").map

			map("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
			map("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
			map("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
			map("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>")
			map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
			map("n", "gR", "<cmd>TroubleToggle lsp_references<cr>")
		end,
	},
}
