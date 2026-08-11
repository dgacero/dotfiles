return {
    -- "ap/vim-buftabline",
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    config = function()
        require("barbar").setup({})
        vim.keymap.set("n", "<leader>n", ":BufferNext<CR>", { desc = "Go to next buffer" })
        vim.keymap.set("n", "<leader>p", ":BufferPrevious<CR>", { desc = "Go to previous buffer" })
        vim.keymap.set("n", "<leader>q", ":BufferClose<CR>", { desc = "Close current buffer" })
    end,
    version = "^1.0.0",
    -- config = function()
    --   vim.g.buftabline_indicators = true
    -- end
}
