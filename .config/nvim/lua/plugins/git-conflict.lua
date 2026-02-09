return {
  "akinsho/git-conflict.nvim",
  config = function()
    local nord8  = "#88c0d0"
    local nord13 = "#ebcb8b"
    local nord15 = "#b48ead"

    local function override_git_conflict_highlights()
      vim.api.nvim_set_hl(
        0, 'GitConflictCurrent',
        { fg = nord8, bold = true }
      )
      vim.api.nvim_set_hl(
        0, 'GitConflictIncoming',
        { fg = nord13, bold = true }
      )
      vim.api.nvim_set_hl(
        0, 'GitConflictAncestor',
        { fg = nord15, bold = true }
      )
      vim.api.nvim_set_hl(
        0, 'GitConflictCurrentLabel',
        { fg = nord8, bold = true, underline = true}
      )
      vim.api.nvim_set_hl(
        0, 'GitConflictIncomingLabel',
        { fg = nord13, bold = true, underline = true }
      )
      vim.api.nvim_set_hl(
        0, 'GitConflictAncestorLabel',
        { fg = nord15, bold = true, underline = true }
      )
    end

    vim.api.nvim_create_autocmd("VimEnter", { callback = override_git_conflict_highlights })

    require("git-conflict").setup({})
  end
}
