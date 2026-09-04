-- [[ Plugin loader ]]
-- With `vim.pack` there is no automatic import or dependency resolution, so
-- plugins are required here explicitly in dependency order (shared libraries
-- such as plenary and nvim-web-devicons are installed by the first module that
-- owns them, before their dependents load).

-- Colorscheme first so it is applied early.
require("plugins.nord")

require("plugins.which-key")

-- Telescope owns plenary + nvim-web-devicons (shared by barbar and nvim-tree).
require("plugins.telescope")

-- Gitsigns before barbar (barbar uses it for buffer git status).
require("plugins.gitsigns")
require("plugins.barbar")
require("plugins.nvim-tree")

-- Completion before LSP.
require("plugins.cmp")
require("plugins.lspconfig")

require("plugins.conform")
require("plugins.treesitter")

require("plugins.autopairs")
require("plugins.indent-blankline")
require("plugins.ts-comments")
require("plugins.guess-indent")
require("plugins.markview")
require("plugins.diffview")
require("plugins.git-conflict")
require("plugins.osyank")
require("plugins.remember")
