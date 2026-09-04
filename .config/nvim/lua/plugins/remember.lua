-- Reopen files at your last edit position.
local gh = require("pack").gh

vim.pack.add({ gh("vladdoster/remember.nvim") })

require("remember").setup({})
