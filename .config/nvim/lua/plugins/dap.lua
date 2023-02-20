-- DAP Configuration & Plugins
return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'mfussenegger/nvim-dap-python',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
            local dap = require('dap')

            -- Auto-complete for the DAP REPL
            vim.cmd [[
              au FileType dap-repl lua require('dap.ext.autocompl').attach()
            ]]

            -- DAP keybindings
            local dap_map = require('helpers.keys').dap_map

            dap_map('n', '<F5>', function() dap.continue() end, 'Start debugging')
            dap_map('n', '<F10>', function() dap.step_over() end, 'Step over')
            dap_map('n', '<F11>', function() dap.step_into() end, 'Step into')
            dap_map('n', '<F12>', function() dap.step_out() end, 'Step out')
            dap_map('n', '<leader>dc', function() dap.close() end, '[D]ebug [C]lose')
            dap_map('n', '<leader>b', function() dap.toggle_breakpoint() end, 'Toggle [B]reakpoint')
            dap_map('n', '<leader>B', function() dap.set_breakpoint() end, 'Set [B]reakpoint')
            dap_map('n', '<leader>lp', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end, 'Set [L]og [P]oint')
            dap_map('n', '<leader>dr', function() dap.repl.open() end, 'Open [D]ebug [R]EPL')
            dap_map('n', '<leader>rl', function() dap.run_last() end, '[R]un [L]ast')

            -- DAP UI
            require('dapui').setup()
            dap_map('n', '<leader>du', function() require('dapui').toggle() end, 'Toggle the [D]ebug [U]I')

            -- Python
            require('dap-python').setup('/usr/bin/python3') -- Sane default configs
            -- TODO: Seems broken...
            -- dap.ext.vscode.load_launchjs()                -- Load from .vscode/launch.json
            table.insert(dap.configurations.python, { -- Custom configs
                type = 'python',
                name = 'My custom config',
                request = 'launch',
                program = '${file}'
            })
        end
    },
}
