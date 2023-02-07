vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function map(mode, rhs, lhs, desc)
	vim.keymap.set(mode, rhs, lhs, { silent = true, desc = desc })
end

map({ 'n', 'v' }, '<space>', '<nop>')
map('i', 'jk', '<esc>')

-- Quick access to some common actions
map('n', '<leader>wf', '<cmd>w<cr>', { desc = '[W]rite [F]ile' })
map('n', '<leader>Wf', '<cmd>w<cr>', { desc = '[W]rite All [F]iles' })
map('n', '<leader>q', '<cmd>q<cr>', { desc = '[Q]uit' })
map('n', '<leader>Q', '<cmd>qa!<cr>', { desc = '[Q]uit' })

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', '<leader>x', vim.diagnostic.open_float)
-- map('n', '<leader>q', vim.diagnostic.setloclist)

-- Better window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Navigate windows to the left' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Navigate windows down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Navigate windows up' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Navigate windows to the right' })

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")
