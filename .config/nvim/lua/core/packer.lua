-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float()
    end,
  },
})

-- Set up plugins
packer.startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  use { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    requires = {
      -- Useful status updates for LSP
      'j-hui/fidget.nvim',
      -- Additional lua stuff for neovim
      'folke/neodev.nvim'
    },
  }

  -- Debug adapters
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'rcarriga/nvim-dap-ui'

  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
  }

  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  use { -- Diagnostics window
    'folke/trouble.nvim',
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- Starter screen
  use 'goolord/alpha-nvim'

  -- Fuzzy Finder (files, lsp, etc)
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

  -- Project management
  use "ahmedkhalf/project.nvim"

  -- Git related plugins
  use 'lewis6991/gitsigns.nvim'

  -- Other fun stuff
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline

  use { -- See current buffers at the top of the editor
    'akinsho/bufferline.nvim',
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  use 'numToStr/Comment.nvim' -- Comment with haste

  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

  use { -- Nicer filetree than NetRW
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }

  -- Some plugins from the mini library
  use 'echasnovski/mini.align' -- Align stuff
  use 'echasnovski/mini.surround' -- Surround stuff
  use 'echasnovski/mini.move' -- Move stuff
  use 'echasnovski/mini.pairs' -- Pairs of stuff

  -- Themes
  use 'ellisonleao/gruvbox.nvim'

  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }

  use {
    'rose-pine/nvim',
    as = 'rose-pine'
  }


  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    packer.sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
