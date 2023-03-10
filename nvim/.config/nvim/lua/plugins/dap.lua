-- DAP Configuration & Plugins
return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mfussenegger/nvim-dap-python",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")

			-- Auto-complete for the DAP REPL
			vim.cmd([[
              au FileType dap-repl lua require('dap.ext.autocompl').attach()
            ]])

			-- DAP keybindings
			local dap_map = require("helpers.keys").dap_map

			dap_map("n", "<F6>", function()
				dap.continue()
			end, "Start debugging")
			dap_map("n", "<F10>", function()
				dap.step_over()
			end, "Step over")
			dap_map("n", "<F11>", function()
				dap.step_into()
			end, "Step into")
			dap_map("n", "<F12>", function()
				dap.step_out()
			end, "Step out")
			dap_map("n", "<leader>bs", function()
				dap.close()
			end, "Stop debgging")
			dap_map("n", "<leader>bb", function()
				dap.toggle_breakpoint()
			end, "Toggle breakpoint")
			dap_map("n", "<leader>bl", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, "Set logpoint")
			dap_map("n", "<leader>br", function()
				dap.repl.open()
			end, "Open debug REPL")
			dap_map("n", "<leader>bL", function()
				dap.run_last()
			end, "Run last")

			-- DAP UI
			require("dapui").setup()
			dap_map("n", "<leader>ud", function()
				require("dapui").toggle()
			end, "Toggle debugging UI")

			-- Python
			require("dap-python").setup("/usr/bin/python3") -- Sane default configs
			-- TODO: Seems broken...
			-- dap.ext.vscode.load_launchjs()                -- Load from .vscode/launch.json
			table.insert(dap.configurations.python, { -- Custom configs
				type = "python",
				name = "My custom config",
				request = "launch",
				program = "${file}",
			})
		end,
	},
}
