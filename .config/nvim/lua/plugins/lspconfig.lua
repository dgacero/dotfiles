-- LSP server configs for the Nvim LSP client, installed via Mason.
local gh = require("pack").gh

vim.pack.add({
    gh("neovim/nvim-lspconfig"),
    -- Automatically install LSP servers and related tools.
    gh("mason-org/mason.nvim"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
    -- Useful status updates for LSP.
    gh("j-hui/fidget.nvim"),
})

-- Mason must be set up before its dependents (mason-lspconfig,
-- mason-tool-installer).
require("mason").setup({})
require("fidget").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("grn", vim.lsp.buf.rename, "Rename")

        map("gra", vim.lsp.buf.code_action, "Goto code action", { "n", "x" })

        -- This is not Goto Definition, this is Goto Declaration. For example,
        -- in C this would take you to the header.
        map("grD", vim.lsp.buf.declaration, "Goto declaration")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight", event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
                end,
            })
        end

        if client and client:supports_method("textDocument/inlayHint", event.buf) then
            map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle inlay hints")
        end
    end,
})

local servers = {
    -- Optional: uncomment any of the servers below to install and configure
    -- them automatically via Mason.
    -- clangd = {},   -- C: LSP.
    -- ruff = {},     -- Python: linter, formatter, LSP.
    -- pyright = {},  -- Python: LSP.
    -- vtsls = {},    -- JS/TS: LSP.
    -- eslint = {},   -- JS/TS: LSP.
    -- prettier = {}, -- JS/TS: formatter.

    stylua = {}, -- Lua: formatter, LSP.

    -- Special Lua config, recommended by the Neovim help docs.
    lua_ls = {
        on_init = function(client)
            -- Disable formatting (formatting is done by stylua).
            client.server_capabilities.documentFormattingProvider = false

            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                -- Respect a project's own `.luarc.json`/`.luarc.jsonc` instead
                -- of overriding it.
                if
                    path ~= vim.fn.stdpath("config")
                    and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
                then
                    return
                end
            end

            local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
            client.config.settings.Lua = vim.tbl_deep_extend("force", current_settings.Lua, {
                runtime = {
                    version = "LuaJIT",
                    path = { "lua/?.lua", "lua/?/init.lua" },
                },
                workspace = {
                    checkThirdParty = false,
                    -- `nvim_get_runtime_file()` includes our own config dir, so
                    -- `lua_ls` sees our files twice and emits spurious
                    -- `[duplicate-doc-field]` warnings.
                    -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                    library = vim.api.nvim_get_runtime_file("", true),
                },
            })
        end,
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace",
                },
                -- Disable formatting (formatting is done by stylua).
                format = { enable = false },
            },
        },
    },
}

local ensure_installed = vim.tbl_keys(servers or {})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

-- Translates between nvim-lspconfig server names and mason.nvim package names
-- (e.g. lua_ls <-> lua-language-server).
require("mason-lspconfig").setup({
    automatic_enable = false,
})

for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
end
