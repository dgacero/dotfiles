-- Auto-detect indentation (tabstop/shiftwidth) per file.
local gh = require("pack").gh

vim.pack.add({ gh("NMAC427/guess-indent.nvim") })

require("guess-indent").setup({})
