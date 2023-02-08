-- Status line
local colorscheme = require('core.colorscheme')
local lualine_theme = colorscheme == "default" and "auto" or colorscheme
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = lualine_theme,
    component_separators = '|',
    section_separators = '',
  },
}

-- Buffer line
require('bufferline').setup()

-- Filetree browser
require("neo-tree").setup()
vim.keymap.set({ 'n', 'v' }, '<leader>e', '<cmd>NeoTreeRevealToggle<cr>', { desc = 'Show the file [E]xplorer' })

-- Show git status in the left gutter
require('gitsigns').setup()

-- Show diagnostics in its own little window
require('trouble').setup()

-- Start-up screen
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[                               __                ]],
	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
require('alpha').setup(dashboard.opts)
vim.keymap.set('n', '<leader>a', '<cmd>Alpha<cr>', { desc = 'Go to the [A]lpha dashboard' })

-- Turn on lsp status information
require('fidget').setup()

