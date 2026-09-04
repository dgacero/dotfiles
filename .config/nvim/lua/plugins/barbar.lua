-- Buffer tabs
local gh = require("pack").gh

-- Must be set before barbar loads. Dependencies gitsigns (git status) and
-- nvim-web-devicons (file icons) are installed earlier by their own modules.
vim.g.barbar_auto_setup = false

vim.pack.add({ { src = gh("romgrk/barbar.nvim"), version = vim.version.range("^1.0.0") } })

require("barbar").setup({})
vim.keymap.set("n", "<leader>n", ":BufferNext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "<leader>p", ":BufferPrevious<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "<leader>q", ":BufferClose<CR>", { desc = "Close current buffer" })
