local map = require('helpers.keys').map

-- Blazingly fast way out of insert mode
map('i', 'jk', '<esc>')

-- Quick access to some common actions
map('n', '<leader>wf', '<cmd>w<cr>', '[W]rite [F]ile')
map('n', '<leader>Wf', '<cmd>wa<cr>', '[W]rite All [F]iles')
map('n', '<leader>q', '<cmd>q<cr>', '[Q]uit')
map('n', '<leader>Q', '<cmd>qa!<cr>', '[Q]uit')
map('n', '<leader>c', '<cmd>close<cr>', '[C]lose Window')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
-- This is handled by Trouble largely now
-- map('n', '<leader>x', vim.diagnostic.open_float)
-- map('n', '<leader>q', vim.diagnostic.setloclist)

-- Better window navigation
map('n', '<C-h>', '<C-w><C-h>', 'Navigate windows to the left')
map('n', '<C-j>', '<C-w><C-j>', 'Navigate windows down')
map('n', '<C-k>', '<C-w><C-k>', 'Navigate windows up')
map('n', '<C-l>', '<C-w><C-l>', 'Navigate windows to the right')

-- Move with Shift-Arrows
map('n', '<S-Left>', '<C-w><S-h>', 'Move window to the left')
map('n', '<S-Down>', '<C-w><S-j>', 'Move window down')
map('n', '<S-Up>', '<C-w><S-k>', 'Move window up')
map('n', '<S-Right>', '<C-w><S-l>', 'Move window to the right')

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
local buffers = require('helpers.buffers')
map('n', '<leader>dd', buffers.delete_this, '[D]elete the current buffer')
map('n', '<leader>do', buffers.delete_others, '[D]elete the [O]ther buffers')
map('n', '<leader>da', buffers.delete_all, '[D]elete [A]ll buffers')

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Switch between light and dark modes
map('n', '<leader>tt', function()
	if vim.o.background == 'dark' then
		vim.o.background = 'light'
	else
		vim.o.background = 'dark'
	end
end, '[T]oggle between light/dark [T]heme')
