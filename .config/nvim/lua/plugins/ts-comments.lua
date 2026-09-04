-- Enhance Neovim's native comments (use `gcc`).
local gh = require("pack").gh

if vim.fn.has("nvim-0.10.0") == 1 then
    vim.pack.add({ gh("folke/ts-comments.nvim") })
    require("ts-comments").setup({})
end
