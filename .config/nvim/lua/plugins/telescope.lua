-- Fuzzy finder over files, buffers, LSP results, and more
local gh = require("pack").gh

-- Telescope owns the shared libraries plenary and nvim-web-devicons (also used
-- by barbar and nvim-tree). telescope-fzf-native is built by the PackChanged
-- hook in `pack.lua` and only installed when `make` is available.
local plugins = {
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-tree/nvim-web-devicons"),
    gh("nvim-telescope/telescope-ui-select.nvim"),
    gh("nvim-telescope/telescope.nvim"),
}
if vim.fn.executable("make") == 1 then
    table.insert(plugins, gh("nvim-telescope/telescope-fzf-native.nvim"))
end
vim.pack.add(plugins)

require("telescope").setup({
    defaults = {
        file_ignore_patterns = { "%.git/" },
        layout_strategy = "vertical",
        layout_config = {
            horizontal = {
                width = 0.9,
                preview_width = 0.55,
            },
            vertical = {
                width = 0.9,
                preview_height = 0.4,
                mirror = true,
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        live_grep = {
            additional_args = { "--hidden", "--glob=!.git" },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
    },
})

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })

vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })

vim.keymap.set("n", "<leader>sf", function()
    require("telescope-pickers").prettyFilesPicker({
        picker = "find_files",
    })
end, { desc = "Search files" })

vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "Search Telescope" })

vim.keymap.set("n", "<leader>sw", function()
    require("telescope-pickers").prettyGrepPicker({ picker = "grep_string" })
end, { desc = "Search current word" })

vim.keymap.set("n", "<leader>sr", function()
    require("telescope-pickers").prettyFilesPicker({
        picker = "oldfiles",
        options = { prompt_title = "Recent Files" },
    })
end, { desc = "Search recent files" })

vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search existing buffers" })

vim.keymap.set("n", "<leader>/", function()
    builtin.current_buffer_fuzzy_find()
end, { desc = "Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader><leader>", function()
    require("telescope-pickers").prettyGrepPicker({
        picker = "live_grep",
        options = { prompt_title = "Live grep in current directory" },
    })
end, { desc = "Search in current directory" })

vim.keymap.set("n", "<leader>so", function()
    require("telescope-pickers").prettyGrepPicker({
        picker = "live_grep",
        options = {
            grep_open_files = true,
            prompt_title = "Live grep in open files",
        },
    })
end, { desc = "Search in open files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
    require("telescope-pickers").prettyFilesPicker({
        picker = "find_files",
        options = { cwd = vim.fn.stdpath("config") },
    })
end, { desc = "Search Neovim files" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
    callback = function(event)
        local buf = event.buf

        -- Find references for the word under your cursor.
        vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "Goto references" })

        -- Jump to the implementation of the word under your cursor.
        vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "Goto implementation" })

        -- Jump to the definition of the word under your cursor.
        vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "Goto definition" })

        -- Fuzzy find all the symbols in your current document.
        vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open document symbols" })

        -- Fuzzy find all the symbols in your current workspace.
        vim.keymap.set(
            "n",
            "gW",
            builtin.lsp_dynamic_workspace_symbols,
            { buffer = buf, desc = "Open workspace symbols" }
        )

        -- Jump to the type of the word under your cursor.
        vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "Goto type definition" })
    end,
})
