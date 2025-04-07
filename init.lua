-- Function to synchronize the system and primary clipboards
local function sync_clipboards()
    local current_reg = vim.fn.getreg('"')
    local current_regtype = vim.fn.getregtype('"')
    vim.fn.setreg('*', current_reg, current_regtype)
    vim.fn.setreg('+', current_reg, current_regtype)
end

-- Automatic clipboard synchronization on every yank operation
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        sync_clipboards()
    end
})

require("anjola.keymaps")
-- require("anjola.plugins")
-- require("anjola.nvim-tree")
require("anjola.options")
-- require("anjola.cmp")
-- require("anjola.neodev")
-- require("anjola.lsp")
-- require("anjola.tree-sitter")
-- require("anjola.telescope")
-- require("anjola.lualine")
-- require("anjola.comment")
-- require("anjola.bufferline")
-- require("anjola.autopairs")
-- require("anjola.indent-blankline")
-- require("anjola.gitsigns")
-- require("anjola.dap")
-- require("anjola.neotest")
-- require("anjola.toggleterm")
-- require("anjola.typescript")
-- require("anjola.cmake-tools")
-- require("anjola.surround")
-- require("anjola.harpoon")
-- require("anjola.rust_tools")
-- vim.cmd("let g:OmniSharp_server_use_net6 = 1 ")
-- vim.cmd("let g:OmniSharp_server_use_mono = 1")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({ { import = "plugins" }, { import = "plugins.lsp" }, {import = "plugins.dap"} }, {
  -- checker = {
  --   enabled = true,
  --   notify = false,
  -- },
  change_detection = {
    notify = false,
  },
})
