return {
	"stevearc/dressing.nvim",
  config = function ()
   require('dressing').setup({
      select = {
        enabled = true,
        backend = { "fzf_lua", "fzf", "builtin", "nui", "telescope" },

      }
    })
  end
}
