-- Auto-close brackets, quotes, and parens
local gh = require("pack").gh

vim.pack.add({ gh("windwp/nvim-autopairs") })

require("nvim-autopairs").setup({})
