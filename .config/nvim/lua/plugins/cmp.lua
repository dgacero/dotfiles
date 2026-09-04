-- Autocompletion
local gh = require("pack").gh

-- LuaSnip's build step (make install_jsregexp) runs via the PackChanged hook in
-- `pack.lua`.
vim.pack.add({
    { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2.*") },
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
})

require("luasnip").setup({})

--- @module 'blink.cmp'
--- @type blink.cmp.Config
require("blink.cmp").setup({
    keymap = {
        -- 'super-tab' lets <Tab> accept the selected completion, mirroring IDE-style tab-completion.
        preset = "super-tab",
    },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
    },

    completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
        default = { "lsp", "path", "snippets" },
    },

    snippets = { preset = "luasnip" },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = { implementation = "lua" },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
})
