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

		-- Floating Tree resize
		local HEIGHT_RATIO = 0.8 -- You can change this
		local WIDTH_RATIO = 0.5 -- You can change this too
		local tree_api = require("nvim-tree")
		local tree_view = require("nvim-tree.view")

		vim.api.nvim_create_augroup("NvimTreeResize", {
			clear = true,
		})

		vim.api.nvim_create_autocmd({ "VimResized" }, {
			group = "NvimTreeResize",
			callback = function()
				if tree_view.is_visible() then
					tree_view.close()
					tree_api.open()
				end
			end,
		})

		nvim_tree.setup({
			update_focused_file = {
				enable = true,
				-- 	update_cwd = true,
			},
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = false,
			},
			actions = {
        use_system_clipboard = true,
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			git = {
				enable = true,
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
				-- left side
				-- width = 30,
				-- side = "left",
				-- floating window
					float = {
						enable = true,
						open_win_config = function()
							local screen_w = vim.opt.columns:get()
							local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
							local window_w = screen_w * WIDTH_RATIO
							local window_h = screen_h * HEIGHT_RATIO
							local window_w_int = math.floor(window_w)
							local window_h_int = math.floor(window_h)
							local center_x = (screen_w - window_w) / 2
							local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
							return {
								border = "rounded",
								relative = "editor",
								row = center_y,
								col = center_x,
								width = window_w_int,
								height = window_h_int,
							}
						end,
					},
					width = function()
						return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
					end,
			},
		})

		require("nvim-treesitter.configs").setup({})
	end,
}
