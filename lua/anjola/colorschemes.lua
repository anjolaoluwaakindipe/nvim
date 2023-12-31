local colorscheme_name = "catppuccin"

-- setup colorscheme settings
local status_ok, scheme = pcall(require, colorscheme_name)
if not status_ok then
	return
end

-- scheme.setup({
-- 	transparent_background = true,
-- })

-- set suffix to color scheme
local colorscheme_suffix = "-mocha"

-- set vim color scheme
local staus_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme_name .. colorscheme_suffix)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme_name .. colorscheme_suffix .. " not found")
	return
end

-- Color scheme for debugger breakpoints
vim.api.nvim_set_hl(0, "blue", { fg = "#3d59a1" })
vim.api.nvim_set_hl(0, "green", { fg = "#9ece6a" })
vim.api.nvim_set_hl(0, "yellow", { fg = "#FFFF00" })
vim.api.nvim_set_hl(0, "orange", { fg = "#f09000" })

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "", texthl = "blue", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "", texthl = "orange", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
)
vim.fn.sign_define("DapStopped", { text = "•", texthl = "green", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "", texthl = "yellow", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
) -- Color scheme for debugger for Debugger
