-- Autoformat
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
    opts = {
        formatters = {
            stylua = {
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

            -- Conform can also run multiple formatters sequentially
            python = { "ruff_format", "ruff_organize_imports" },

            -- You can use 'stop_after_first' to run the first available formatter from the list
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
    },
}
