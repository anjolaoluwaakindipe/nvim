return {
	{
		"radyz/telescope-gitsigns",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		-- opts = {
		--
		-- 	signcolumn = true,
		-- 	_signs_staged_enable = true, -- experimental
		--
		-- 	signs = {
		-- 		add = { hl = "GitSignsAdd", text = "┃", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		-- 		change = { hl = "GitSignsChange", text = "┃", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		-- 		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		-- 		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		-- 		changedelete = {
		-- 			hl = "GitSignsChange",
		-- 			text = "┃",
		-- 			numhl = "GitSignsChangeNr",
		-- 			linehl = "GitSignsChangeLn",
		-- 		},
		-- 	},
		-- 	_signs_staged = {
		-- 		add = {
		-- 			hl = "GitSignsStagedAdd",
		-- 			text = "┋ ",
		-- 			numhl = "GitSignsStagedAddNr",
		-- 			linehl = "GitSignsStagedAddLn",
		-- 		},
		-- 		change = {
		-- 			hl = "GitSignsStagedChange",
		-- 			text = "┋ ",
		-- 			numhl = "GitSignsStagedChangeNr",
		-- 			linehl = "GitSignsStagedChangeLn",
		-- 		},
		-- 		delete = {
		-- 			hl = "GitSignsStagedDelete",
		-- 			text = "﹍",
		-- 			numhl = "GitSignsStagedDeleteNr",
		-- 			linehl = "GitSignsStagedDeleteLn",
		-- 		},
		-- 		topdelete = {
		-- 			hl = "GitSignsStagedDelete",
		-- 			text = "﹉",
		-- 			numhl = "GitSignsStagedDeleteNr",
		-- 			linehl = "GitSignsStagedDeleteLn",
		-- 		},
		-- 		changedelete = {
		-- 			hl = "GitSignsStagedChange",
		-- 			text = "┋ ",
		-- 			numhl = "GitSignsStagedChangeNr",
		-- 			linehl = "GitSignsStagedChangeLn",
		-- 		},
		-- 	},
		-- 	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		-- 	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		-- 	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		-- 	watch_gitdir = {
		-- 		interval = 1000,
		-- 		follow_files = true,
		-- 	},
		-- 	attach_to_untracked = true,
		-- 	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		-- 	current_line_blame_opts = {
		-- 		virt_text = true,
		-- 		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		-- 		delay = 1000,
		-- 		ignore_whitespace = false,
		-- 	},
		-- 	current_line_blame_formatter_opts = {
		-- 		relative_time = false,
		-- 	},
		-- 	sign_priority = 6,
		-- 	update_debounce = 100,
		-- 	status_formatter = nil, -- Use default
		-- 	max_file_length = 40000,
		-- 	preview_config = {
		-- 		-- Options passed to nvim_open_win
		-- 		border = "single",
		-- 		style = "minimal",
		-- 		relative = "cursor",
		-- 		row = 0,
		-- 		col = 1,
		-- 	},
		-- 	yadm = {
		-- 		enable = false,
		-- 	},
		-- },
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				-- navigate hunks
				map("n", "gs]", function()
					gitsigns.nav_hunk("next")
				end)

				map("n", "gs[", function()
					gitsigns.nav_hunk("prev")
				end)

				-- actions
				map("n", "gsr", gitsigns.reset_hunk)
				map("n", "gss", gitsigns.stage_hunk)
				map("v", "gss", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("v", "gsr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("n", "gsb", function()
					gitsigns.blame_line({ full = true })
				end)
				map("n", "gsbt", gitsigns.toggle_current_line_blame)

				-- preview
				map("n", "gsp", gitsigns.preview_hunk)
				map("n", "gspi", gitsigns.preview_hunk_inline)
			end,

			signcolumn = true,
			signs_staged_enable = true, -- experimental

			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = {
					text = "┃",
				},
			},
			signs_staged = {
				add = {
					text = "┋ ",
				},
				change = {
					text = "┋ ",
				},
				delete = {
					text = "﹍",
				},
				topdelete = {
					text = "﹉",
				},
				changedelete = {
					text = "┋ ",
				},
			},
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},
			-- current_line_blame_formatter_opts = {
			-- 	relative_time = false,
			-- },
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000,
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
}
