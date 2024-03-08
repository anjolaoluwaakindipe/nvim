local status_ok, harpoon = pcall(require, "harpoon")

if not status_ok then
	return
end

harpoon:setup()
-- local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():append()
end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>hh", function()
	toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

-- pick a specific file
vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<leader>h5", function()
	harpoon:list():select(5)
end)
vim.keymap.set("n", "<leader>h6", function()
	harpoon:list():select(6)
end)
vim.keymap.set("n", "<leader>h7", function()
	harpoon:list():select(7)
end)
vim.keymap.set("n", "<leader>h8", function()
	harpoon:list():select(8)
end)
vim.keymap.set("n", "<leader>h9", function()
	harpoon:list():select(9)
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hn", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>hp", function()
	harpoon:list():next()
end)

harpoon:extend({
	UI_CREATE = function(cx)
		vim.keymap.set("n", "<C-v>", function()
			harpoon.ui:select_menu_item({ vsplit = true })
		end, { buffer = cx.bufnr })

		vim.keymap.set("n", "<C-x>", function()
			harpoon.ui:select_menu_item({ split = true })
		end, { buffer = cx.bufnr })

		vim.keymap.set("n", "<C-t>", function()
			harpoon.ui:select_menu_item({ tabedit = true })
		end, { buffer = cx.bufnr })
	end,
})

vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")
