-- language specifics
-- templ

-- run custom format through command line then refresh buffer else format the buffer itself
local custom_format = function()
	if vim.bo.filetype == "templ" then
		local bufnr = vim.api.nvim_get_current_buf()
		local filename = vim.api.nvim_buf_get_name(bufnr)
		local cmd = "templ fmt " .. vim.fn.shellescape(filename)

		vim.fn.jobstart(cmd, {
			on_exit = function()
				-- Reload the buffer only if it's still the current buffer
				if vim.api.nvim_get_current_buf() == bufnr then
					vim.cmd("e!")
				end
			end,
		})
	else
		vim.lsp.buf.format()
	end
end
vim.filetype.add({ extension = { templ = "templ" } }) -- add extension to vim
vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*.templ" }, callback = custom_format }) -- format on save

return {
	settings = {},
}
