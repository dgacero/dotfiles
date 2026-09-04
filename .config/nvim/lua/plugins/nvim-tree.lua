-- File explorer sidebar.
local gh = require("pack").gh

-- nvim-web-devicons is installed earlier by the telescope module.
vim.pack.add({ gh("nvim-tree/nvim-tree.lua") })

require("nvim-tree").setup({
    filters = {
        dotfiles = false,
    },
    live_filter = {
        prefix = "[FIND]: ",
        always_show_folders = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = false,
    },
    view = {
        adaptive_size = false,
        side = "left",
        width = 30,
        preserve_window_proportions = true,
    },
    git = {
        enable = true,
        ignore = false,
    },
    filesystem_watchers = {
        enable = false,
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
    renderer = {
        highlight_git = true,
        highlight_opened_files = "none",
        indent_markers = {
            enable = true,
        },
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = false,
            },
        },
    },
})

vim.keymap.set("n", "<C-n>", function()
    require("nvim-tree.api").tree.toggle()
end, { silent = true, noremap = true, desc = "Toggle file explorer" })

-- Keep `:bd` and `:q` from being swallowed by the tree window, which nvim-tree
-- doesn't handle on its own.
vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
    nested = false,
    callback = function(e)
        local tree = require("nvim-tree.api").tree

        if not tree.is_visible() then
            return
        end

        -- Exclude non-focusable windows (e.g. which-key popups, LSP hover)
        -- from the count.
        local winCount = 0
        for _, winId in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_config(winId).focusable then
                winCount = winCount + 1
            end
        end

        -- Two focusable windows means only the tree and one other window are
        -- left.
        if e.event == "QuitPre" and winCount == 2 then
            vim.api.nvim_cmd({ cmd = "qall" }, {})
        end

        -- `:bd` was probably issued and only the tree window is left, so behave
        -- as if the tree was closed (see `:h :bd`).
        if e.event == "BufEnter" and winCount == 1 then
            -- Required to avoid "Vim:E444: Cannot close last window".
            vim.defer_fn(function()
                -- Close the tree, landing on the last buffer used before
                -- closing.
                tree.toggle({ find_file = true, focus = true })
                tree.toggle({ find_file = true, focus = false })
            end, 10)
        end
    end,
})
