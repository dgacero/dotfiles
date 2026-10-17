-- Markdown/HTML/LaTeX/Typst/YAML previewer.
local gh = require("pack").gh

vim.pack.add({ gh("OXY2DEV/markview.nvim") })

-- Default heading style shows a Nerd Font icon per level instead of the raw "#"
-- markers, which is hard to read at a glance. Use `simple` to keep the markers.
local heading_levels = {}
for n = 1, 6 do
    heading_levels["heading_" .. n] = { style = "simple" }
end

-- Dashes of 3 chars with a 1-space gap, repeated across the full line width.
local hr_rule = {
    enable = true,
    parts = {
        {
            type = "repeating",
            repeat_amount = function()
                return vim.o.columns
            end,
            repeat_text = true,
            text = { "─", "─", "─", " " },
            hl = "MarkviewPalette1Fg",
        },
    },
}

require("markview").setup({
    markdown = {
        headings = heading_levels,
        horizontal_rules = hr_rule,
    },
})

local nord = require("nord.colors")

-- Matches nord.nvim's `Headline3` bg: (10 * nord0 + nord14) / 11.
local heading_bg = "#394147"

-- markview colors headings via `MarkviewPaletteN` groups.
for n = 1, 6 do
    vim.api.nvim_set_hl(0, "MarkviewPalette" .. n, { fg = nord.nord14_gui, bg = heading_bg })
    vim.api.nvim_set_hl(0, "MarkviewPalette" .. n .. "Bg", { bg = heading_bg })
end
