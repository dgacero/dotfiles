local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

----- GENERAL SETTINGS -----
config.audible_bell = "Disabled"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font({
  family = "JetBrains Mono",
  weight = 400,
})
config.font_size = 14

-- Disable ligatures
-- See https://wezterm.org/config/font-shaping.html#advanced-font-shaping-options
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

----- COLOR SCHEME -----
config.color_scheme = "nord"

-- Nord theme with extra darker color
-- See https://www.nordtheme.com/docs/colors-and-palettes
local nord_darker = "#242933"
local nord0 = "#2e3440"
local nord2 = "#434c5e"
local nord6 = "#eceff4"

config.colors = {
  background = nord_darker,
  tab_bar = {
    background = nord_darker,
    active_tab = {
      bg_color = nord_darker,
      fg_color = nord6,
    },
    inactive_tab = {
      bg_color = nord0,
      fg_color = nord6,
    },
    inactive_tab_hover = {
      bg_color = nord2,
      fg_color = nord6,
    },
    new_tab = {
      bg_color = nord0,
      fg_color = nord6,
    },
    new_tab_hover = {
      bg_color = nord2,
      fg_color = nord6,
    }
  }
}

return config
