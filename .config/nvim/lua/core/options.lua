local opts = {
	shiftwidth = 4,
	tabstop = 4,
	expandtab = true,
}

for opt, val in pairs(opts) do
	vim.o[opt] = val
end
