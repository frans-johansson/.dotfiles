local M = {}

M.map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

M.lsp_map = function(lhs, rhs, bufnr, desc)
    if desc then
	desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
end

M.dap_map  =  function(mode, lhs, rhs, description)
    M.map(mode, lhs, rhs, { desc = 'DBG: ' .. description })
end

return M
