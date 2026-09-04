-- Enable faster startup by caching compiled Lua modules.
vim.loader.enable()

-- Must happen before plugins are loaded, otherwise the wrong leader is used.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if a Nerd Font is installed and selected in the terminal.
vim.g.have_nerd_font = true

require("options")
require("keymaps")
require("pack")
require("plugins")
