return {
  "Bekaboo/deadcolumn.nvim",
  config = function()
    vim.opt.colorcolumn = "133"

    require("deadcolumn").setup({
      -- scope = function()
      --   local max = 0
      --   for i = -5, 5 do
      --     local len = vim.fn.strdisplaywidth(
      --       vim.fn.getline(vim.fn.line(".") + i)
      --     )
      --     if len > max then
      --       max = len
      --     end
      --   end
      --   return max
      -- end,
      modes = function(mode)
        return mode:find('^[niRss\x13]') ~= nil
      end,
      blending = {
        threshold = 0.8,
        colorcode = "#000000",
        hlgroup = { "Normal", "bg" },
      },
      warning = {
        alpha = 1,
        offset = 0,
        colorcode = "#bf616a",
        hlgroup = { "Error", "bg" }
      }
    })
  end
}
