-- Nord colorscheme
local gh = require("pack").gh

vim.pack.add({ gh("shaunsingh/nord.nvim") })

-- Disable italics
vim.g.nord_italic = false
-- Allow Neovim to use the terminal background
vim.g.nord_disable_background = true
-- Disable colorful backgrounds when used in diff mode
vim.g.nord_uniform_diff_background = true

vim.cmd.colorscheme("nord")
