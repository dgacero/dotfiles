-- Never show the status line.
vim.o.laststatus = 0

-- Show the line number for every line.
vim.o.number = true
-- Combined with `number`, other lines show their distance from the cursor.
vim.o.relativenumber = true

-- Enable mouse mode (useful for resizing splits).
vim.o.mouse = "a"

-- Don't show the mode indicator (e.g. "-- INSERT --") in the command line.
vim.o.showmode = false

-- Every wrapped line continues visually indented, preserving horizontal
-- blocks of text.
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file.
vim.o.undofile = true

-- Case-insensitive searching unless \C or one or more capital letters are in
-- the search term.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Idle time (ms) before the swap file writes and `CursorHold` fires, which
-- plugins use for things like LSP reference highlighting (see
-- `lspconfig.lua`). Lower than the 4s default so that feels responsive.
vim.o.updatetime = 250

-- Time (ms) to wait for a mapped key sequence (e.g. the leader key) before
-- giving up on it.
vim.o.timeoutlen = 300

-- Open new splits to the right/below, not Vim's default left/above.
vim.o.splitright = true
vim.o.splitbelow = true

-- Display certain whitespace characters in the editor. Uses `vim.opt`
-- instead of `vim.o` since only it can take a table value.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions as you type, with a split showing off-screen matches.
vim.o.inccommand = "split"

-- Highlight the entire line the cursor is on, not just the cursor itself.
vim.o.cursorline = true

-- Keep a minimal number of screen lines above and below the cursor.
vim.o.scrolloff = 10

-- Raise a dialog to save changes instead of failing operations like `:q`.
vim.o.confirm = true

-- Fallback indent settings. guess-indent.nvim overrides these per buffer when
-- detection succeeds.
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
