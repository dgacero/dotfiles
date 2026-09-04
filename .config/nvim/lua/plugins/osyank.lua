-- Copy to system clipboard over SSH via OSC52.
local gh = require("pack").gh

vim.pack.add({ gh("ojroques/nvim-osc52") })

require("osc52").setup({})

local function copy()
    -- Only mirror the unnamed register, so named-register yanks/deletes don't
    -- overwrite the system clipboard.
    if (vim.v.event.operator == "y" or vim.v.event.operator == "d") and vim.v.event.regname == "" then
        require("osc52").copy_register("")
    end
end

vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
