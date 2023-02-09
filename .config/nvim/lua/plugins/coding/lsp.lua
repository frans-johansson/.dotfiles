-- Neodev setup before LSP config
require("neodev").setup()

-- Set up cool signs for diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- LSP settings.
-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local lsp_map = require('helpers.keys').lsp_map

  lsp_map('<leader>rn', vim.lsp.buf.rename, bufnr, '[R]e[n]ame')
  lsp_map('<leader>ca', vim.lsp.buf.code_action, bufnr, '[C]ode [A]ction')

  lsp_map('gd', vim.lsp.buf.definition, bufnr, '[G]oto [D]efinition')
  lsp_map('gr', require('telescope.builtin').lsp_references, bufnr, '[G]oto [R]eferences')
  lsp_map('gI', vim.lsp.buf.implementation, bufnr, '[G]oto [I]mplementation')
  lsp_map('<leader>D', vim.lsp.buf.type_definition, bufnr, 'Type [D]efinition')
  lsp_map('<leader>ds', require('telescope.builtin').lsp_document_symbols, bufnr, '[D]ocument [S]ymbols')
  lsp_map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, bufnr, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- lsp_map('K', vim.lsp.buf.hover, bufnr, 'Hover Documentation')
  -- lsp_map('<C-k>', vim.lsp.buf.signature_help, bufnr, 'Signature Documentation')

  -- Lesser used LSP functionality
  lsp_map('gD', vim.lsp.buf.declaration, bufnr, '[G]oto [D]eclaration')
  lsp_map('<leader>wa', vim.lsp.buf.add_workspace_folder, bufnr, '[W]orkspace [A]dd Folder')
  lsp_map('<leader>wr', vim.lsp.buf.remove_workspace_folder, bufnr, '[W]orkspace [R]emove Folder')
  lsp_map('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufnr, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })

  lsp_map('<leader>fd', '<cmd>Format<cr>', bufnr, '[F]ormat [D]ocument')
end

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Lua
require('lspconfig')['sumneko_lua'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  }
}

-- Python
require('lspconfig')['pylsp'].setup {
  on_attach = on_attach,
  capabilities = capabilities
}
