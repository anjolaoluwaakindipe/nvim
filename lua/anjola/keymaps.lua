local opts = { noremap = true, silent = true }

local term_opts = { silent = true }



-- Shorten function name
local keymap = vim.keymap.set
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
--
-- yanks
-- keymap("n", "<leader>y", "\"+y", opts)
-- keymap("v", "<leader>y", "\"+y", opts)
-- keymap("n", "<leader>Y", "\"+yg_", opts)
-- keymap("n", "<leader>yy", "\"+yy", opts)
--
-- -- pastes
-- keymap("n", "<leader>p", "\"+p", opts)
-- keymap("v", "<leader>p", "\"+p", opts)
-- keymap("n", "<leader>P", "\"+P", opts)
-- keymap("v", "<leader>P", "\"+P", opts)


-- clear search highlights
keymap("n", "<leader>nh", ":nohl<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- window management
keymap("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
keymap("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>", opts) -- close current split window

-- tab management
keymap("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
keymap("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
keymap("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
keymap("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Resize with arrows
keymap("n", "<Tab><Up>", ":resize -2<CR>", opts)
keymap("n", "<Tab><Down>", ":resize +2<CR>", opts)
keymap("n", "<Tab><Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Tab><Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv^", opts)
keymap("v", ">", ">gv^", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":m '>+1<CR>gv=gv", opts)
keymap("x", "K", ":m '<-2<CR>gv=gv", opts)
keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- delete whole word in insert mode
keymap("i", "<M-BS>", "<C-W>", opts)

-- Plugins
--NVIM TREE
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>ef", ":NvimTreeFocus<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts) -- find files within current working directory, respects .gitignore
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts) -- find string in current working directory as you type
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts) -- find string under cursor in current working directory
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts) -- list open buffers in current neovim instance
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts) -- list available help tags

-- Neotest
keymap("n", "<leader>mR", ':lua require("neotest").run.run({strategy="dap"}) <CR>', opts) -- neotest with dap
keymap("n", "<leader>mr", ':lua require("neotest").run.run() <CR>', opts) -- normal neotest the closes suite or funtion
keymap("n", "<leader>mrf", ':lua require("neotest").run.run(vim.fn.expand("%")) <CR>', opts) -- neotest the whole file
keymap(
	"n",
	"<leader>mo",
	':lua require("neotest").output.open({enter=true, auto_close=true, last_run=true}) <CR>',
	opts
) -- neotest output of single test
keymap("n", "<leader>mop", ':lua require("neotest").output_panel.toggle() <CR>', opts) -- neotest toggle output panel of entire test
keymap("n", "<leader>mopc", ':lua require("neotest").output_panel.clear() <CR>', opts) -- clear neotest output panel of single test
keymap("n", "<leader>ms", ':lua require("neotest").summary.toggle() <CR>', opts) -- neotest output of single test
keymap("n", "<leader>mn", ':lua require("neotest").jump.next() <CR>', opts) -- neotest jump to next test
keymap("n", "<leader>mp", ':lua require("neotest").jump.prev() <CR>', opts) -- neotest jump to previous test

-- DAP
-- keymap("n", "<leader>dt", ":lua require('dapui').toggle() <CR>", opts) -- DAP toggle UI
-- keymap("n", "<leader>db", ":DapToggleBreakpoint<CR>", opts) -- DAP toggle breakpoint
-- keymap("n", "<leader>dc", ":DapContinue<CR>", opts) -- DAP Continue
-- keymap("n", "<leader>dr", ":lua require('dapui').open({reset=true})<CR>", opts) -- DAP toggle breakpoint

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
