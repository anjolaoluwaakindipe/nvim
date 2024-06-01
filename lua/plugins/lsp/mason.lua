return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				border = "none",
				icons = {
					package_installed = "◍",
					package_pending = "◍",
					package_uninstalled = "◍",
				},
			},
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
		})

		local lsp_servers = {
			"tsserver",
			"html",
			"cssls",
			"tailwindcss",
			"lua_ls",
			"emmet_ls",
			"omnisharp",
			-- "csharp_ls",
			"zls",
			"jdtls",
			"pyright",
			"rust_analyzer",
			"svelte",
			"prismals",
			"clangd",
			"jsonls",
			"cmake",
			"templ",
			"htmx",
		}

		mason_lspconfig.setup({

			-- list of servers for mason to install
			ensure_installed = lsp_servers,
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed)
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"eslint",
				"gopls",
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
			},
			lazy = true,
		})
	end,
}
