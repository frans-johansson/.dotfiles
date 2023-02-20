-- Take care of the core stuff first
require('core.packer')
require('core.keymaps')
require('core.options')

-- Then we configure all the plugin stuff here
require('plugins.coding.lsp')
require('plugins.coding.cmp')
require('plugins.coding.treesitter')
require('plugins.debugging.dap')
require('plugins.editor.ui')
require('plugins.editor.misc')
require('plugins.editor.alpha')
require('plugins.editor.telescope')
require('plugins.editor.utils')

