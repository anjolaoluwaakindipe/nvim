return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "antosha417/nvim-lsp-file-operations" },
	lazy = false,
	config = function()
		require("lsp-file-operations").setup()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable highlight groups
		vim.opt.termguicolors = true

		local status_ok, nvim_tree = pcall(require, "nvim-tree")

		if not status_ok then
			vim.notify("Could not setup nvim_tree")
			return
		end

		vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]]) -- COLOR FOR THE FOLDER ERRORS

		nvim_tree.setup({
			update_focused_file = {
				enable = true,
				-- 	update_cwd = true,
			},
			actions = {
				open_file = {

					window_picker = {
						enable = false,
					},
				},
			},
			git = {
				-- enable = true,
				ignore = false,
				-- show_on_dirs = true,
				-- show_on_open_dirs = true,
				-- disable_for_dirs = {},
				-- timeout = 400,
				-- cygwin_support = false,
			},
			renderer = {
				root_folder_modifier = ":t",
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				width = 30,
				side = "left",
			},
		})

		require("nvim-treesitter.configs").setup({})
	end,
}
