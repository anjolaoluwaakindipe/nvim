local status_ok, lspconfig = pcall(require, "lspconfig")

if not status_ok then 
  return 
end

require("anjola.lsp.handlers").setup()
require "anjola.lsp.mason"
require("anjola.lsp.lspsaga")
require("anjola.lsp.null-ls")
