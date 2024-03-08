local status, comment = pcall(require, "Comment")
if not status then
	return
end

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})
vim.opt.updatetime = 100
vim.g.skip_ts_context_commentstring_module = true
-- vim.g.skip_ts_context_commentstring_module = true

comment.setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
