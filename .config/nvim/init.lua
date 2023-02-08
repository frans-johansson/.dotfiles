-- Take care of the core stuff first
require('core.packer')
require('core.keymaps')
require('core.options')
require('core.colorscheme')

-- Then we configure all the plugin stuff here
require('plugins.lsp')
require('plugins.dap')
require('plugins.cmp')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.editor')
require('plugins.utils')


