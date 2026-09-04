-- Autocompletion.
local gh = require("pack").gh

-- LuaSnip's build step (`make install_jsregexp`) runs via the `PackChanged`
-- hook in `pack.lua`.
vim.pack.add({
    { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") },
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
})

require("luasnip").setup({})

require("blink.cmp").setup({
    keymap = {
        -- 'super-tab' lets <Tab> accept the selected completion, mirroring
        -- IDE-style tab-completion.
        preset = "super-tab",
    },

    appearance = {
        -- Align icon spacing for the Nerd Font Mono variant.
        nerd_font_variant = "mono",
    },

    completion = {
        -- Press <C-Space> to show completion docs manually, since auto_show is
        -- disabled.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
        default = { "lsp", "path", "snippets" },
    },

    snippets = { preset = "luasnip" },

    -- Use the Lua fuzzy matcher to avoid downloading a prebuilt binary.
    fuzzy = { implementation = "lua" },

    signature = { enabled = true },
})
