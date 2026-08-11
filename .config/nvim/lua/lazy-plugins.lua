-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
require("lazy").setup({
    -- Import plugins from `lua/plugins/*.lua`
    spec = {
        { import = "plugins" },
    },
    -- Disable luarocks
    rocks = { enabled = false },
})

-- vim: ts=2 sts=2 sw=2 et
