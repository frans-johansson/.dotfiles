local dap = require('dap')

vim.cmd [[
  au FileType dap-repl lua require('dap.ext.autocompl').attach()
]]

-- DAP keybindings
local function dmap(mode, lhs, rhs, description)
  vim.keymap.set(mode, lhs, rhs, { desc = 'DBG: ' .. description })
end

dmap('n', '<F5>', function() dap.continue() end, 'Start debugging')
dmap('n', '<F10>', function() dap.step_over() end, 'Step over')
dmap('n', '<F11>', function() dap.step_into() end, 'Step into')
dmap('n', '<F12>', function() dap.step_out() end, 'Step out')
dmap('n', '<leader>dc', function() dap.close() end, '[D]ebug [C]lose')
dmap('n', '<leader>b', function() dap.toggle_breakpoint() end, 'Toggle [B]reakpoint')
dmap('n', '<leader>B', function() dap.set_breakpoint() end, 'Set [B]reakpoint')
dmap('n', '<leader>lp', function()
  dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, 'Set [L]og [P]oint')
dmap('n', '<leader>dr', function() dap.repl.open() end, 'Open [D]ebug [R]EPL')
dmap('n', '<leader>rl', function() dap.run_last() end, '[R]un [L]ast')

-- DAP UI
require('dapui').setup()
dmap('n', '<leader>du', function() require('dapui').toggle() end, 'Toggle the [D]ebug [U]I')

-- Python
require('dap-python').setup('/usr/bin/python3')  -- Sane default configs
-- TODO: Seems broken...
-- dap.ext.vscode.load_launchjs()                -- Load from .vscode/launch.json
table.insert(dap.configurations.python, {        -- Custom configs
  type = 'python',
  name = 'My custom config',
  request = 'launch',
  program = '${file}'
})
