-- Status line
local colorscheme = require('helpers.colorscheme')
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
require('helpers.keys').map({ 'n', 'v' }, '<leader>e', '<cmd>NeoTreeRevealToggle<cr>', 'Show the file [E]xplorer' )

