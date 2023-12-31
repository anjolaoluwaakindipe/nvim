local status_ok, neotest = pcall(require, "neotest")

if not status_ok then
	vim.notify("Could not setup neotest")
	return
end
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)

neotest.setup({
	adapters = {
		require("neotest-go"),
		require("neotest-jest"),
		--     (
		--     {
		-- 	-- jestCommand = "npm test --",
		-- 	-- jestConfigFile = "custom.jest.config.ts",
		-- 	-- env = { CI = true },
		-- 	-- cwd = function(path)
		-- 	-- 	return vim.fn.getcwd()
		-- 	-- end,
		-- }
		--   ),
	},
})
