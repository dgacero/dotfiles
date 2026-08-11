 -- Enhance Neovim's native comments (use "gcc")
return {
  "folke/ts-comments.nvim",
  event = "VimEnter",
  opts = {},
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}

