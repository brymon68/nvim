local colorscheme = "kanagawa"
-- vim.g.catppuccin_flavour = "frappe" -- latte, frappe, macchiato, mocha
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	-- vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end
