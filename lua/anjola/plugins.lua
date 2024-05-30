local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use({
		"nvimdev/guard.nvim",
		-- Builtin configuration, optional
		requires = {
			"nvimdev/guard-collection",
		},
	})
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "nvim-lua/popup.nvim" })

	-- integration with tmux
	use({ "christoomey/vim-tmux-navigator" }) -- for navigating between tmux and neovim

	-- color scheme
	-- use({ "rebelot/kanagawa.nvim" })
	use({ "catppuccin/nvim", as = "catppuccin" })

	-- autocompletion
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua" })

	-- snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" })

	--nvim tree
	use({ "nvim-tree/nvim-web-devicons" })
	use({ "nvim-tree/nvim-tree.lua" })

	-- nvim lsp file operations
	use({
		"antosha417/nvim-lsp-file-operations",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	})

	-- Tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/nvim-tree-docs")

	-- gitsigns
	use("lewis6991/gitsigns.nvim")

	-- nvim lsp
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	-- use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
	use({
		"nvimdev/lspsaga.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lspsaga").setup({})
		end,
	})
	use({ "RRethy/vim-illuminate" })
	use({ "onsails/lspkind.nvim" })
	use({ "lvimuser/lsp-inlayhints.nvim" })

	--telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })

	-- comments
	use({
		"numToStr/Comment.nvim",
	})

	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
	})

	-- lualine (status line)
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- autopairs
	use("windwp/nvim-autopairs")

	-- blankline (bracket lines)
	use("lukas-reineke/indent-blankline.nvim")

	-- dap
	use({ "mfussenegger/nvim-dap", requires = { "leoluz/nvim-dap-go" } })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })
	use({ "jay-babu/mason-nvim-dap.nvim" })
	use({ "theHamsta/nvim-dap-virtual-text" })
	use({ "nvim-telescope/telescope-dap.nvim" })

	-- dap for specific languages
	use({
		"mxsdev/nvim-dap-vscode-js",
		requires = { "mfussenegger/nvim-dap" },
	}) -- typescript/javascript
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})
	-- neo dev
	use("folke/neodev.nvim")

	-- neo test
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
			"Issafalcon/neotest-dotnet",
		},
	})

	-- toggleterm
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- NX - workspace
	use({
		"Equilibris/nx.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("nx").setup({})
		end,
	})

	-- typescript
	use({
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("typescript-tools").setup({})
		end,
	})

	-- cmake
	use("Civitasv/cmake-tools.nvim")

	-- harpoon
	use({ "ThePrimeagen/harpoon", requires = {
		"nvim-telescope/telescope.nvim",
	}, branch = "harpoon2" })

	-- surround text
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})

	-- language specific
	-- c#
	use("Hoffs/omnisharp-extended-lsp.nvim")
	-- use("OmniSharp/omnisharp-vim")
	-- use("Decodetalkers/csharpls-extended-lsp.nvim")

	-- codieum
	-- use({
	-- 	"Exafunction/codeium.vim",
	-- 	config = function()
	-- 		-- Change '<C-g>' here to any keycode you like.
	-- 		vim.keymap.set("i", "<C-g>", function()
	-- 			return vim.fn["codeium#Accept"]()
	-- 		end, { expr = true, silent = true })
	-- 		vim.keymap.set("i", "<c-;>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](1)
	-- 		end, { expr = true, silent = true })
	-- 		vim.keymap.set("i", "<c-,>", function()
	-- 			return vim.fn["codeium#CycleCompletions"](-1)
	-- 		end, { expr = true, silent = true })
	-- 		vim.keymap.set("i", "<c-x>", function()
	-- 			return vim.fn["codeium#Clear"]()
	-- 		end, { expr = true, silent = true })
	-- 	end,
	-- })
	-- rust
	-- use("simrat39/rust-tools.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
