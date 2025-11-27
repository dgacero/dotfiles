-- Nord theme
--[[
return {
  'AlexvZyl/nordic.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('nordic').load({
      on_palette = function(palette)
        blue0 = palette.blue0
        blue1 = palette.blue1
        cyan_dim = palette.cyan.dim

        palette.red.base = blue0  -- Keywords (return, import, try, except, for)
        -- palette.orange.base = blue0  -- Modifiers (public, private, static, final, abstract)
        palette.yellow.base = blue1  -- Class names, variable types
      end,
    })
  end
}
]]
return {
  "shaunsingh/nord.nvim",
  -- lazy = false,
  -- priority = 100,
  config = function()
    -- Disable italics
    vim.g.nord_italic = false
    -- Allow NeoVim to use the terminal background
    vim.g.nord_disable_background = true
    -- Disable colorful backgrounds when used in diff mode
    vim.g.nord_uniform_diff_background = true

    vim.cmd.colorscheme("nord")
  end,
}
