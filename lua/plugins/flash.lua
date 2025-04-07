return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- stylua: ignore
  keys = {
    { "su", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "Su", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "ru", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "Ru", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>u", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
