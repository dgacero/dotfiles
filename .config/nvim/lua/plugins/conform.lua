-- Autoformat.
local gh = require("pack").gh

vim.pack.add({ gh("stevearc/conform.nvim") })

require("conform").setup({
    formatters = {
        stylua = {
            -- Fall back to a 4 space default only when no project stylua config
            -- exists.
            append_args = function(self, ctx)
                local found = vim.fs.find({ ".stylua.toml", "stylua.toml" }, { upward = true, path = ctx.dirname })
                if #found > 0 then
                    return {}
                end
                return { "--indent-type", "Spaces", "--indent-width", "4" }
            end,
        },
    },
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
    },
})

vim.keymap.set("", "<leader>f", function()
    require("conform").format({ async = true })
end, { desc = "Format buffer" })
