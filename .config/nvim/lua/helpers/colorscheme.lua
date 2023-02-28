-- Fetch and setup colorscheme if available, otherwise just return 'default'
-- This should prevent Neovim from complaining about missing colorschemes on first boot
local function get_if_available(name, opts)
	local ok, colorscheme = pcall(require, name)
	if ok then
		colorscheme.setup(opts)
		return name
	else
		return "default"
	end
end

-- Uncomment the colorscheme to use
local colorscheme = get_if_available("catppuccin")
-- local colorscheme = get_if_available('gruvbox')
-- local colorscheme = get_if_available('rose-pine')

return colorscheme
