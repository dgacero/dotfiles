return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({})

    local function copy()
      if ((vim.v.event.operator == "y" or vim.v.event.operator == "d")
          and vim.v.event.regname == "") then
        require("osc52").copy_register("")
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,
}
