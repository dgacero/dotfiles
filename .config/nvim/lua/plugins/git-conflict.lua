return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    local current_color = "#88c0d0"
    local incoming_color = "#a3be8c"
    local ancestor_color = "#b48ead"
    vim.api.nvim_set_hl(
      0, 'GitConflictCurrent',
      { foreground = current_color, bold = true, default = true }
    )
    vim.api.nvim_set_hl(
      0, 'GitConflictIncoming',
      { foreground = incoming_color, bold = true, default = true }
    )
    vim.api.nvim_set_hl(
      0, 'GitConflictAncestor',
      { foreground = ancestor_color, bold = true, default = true }
    )
    vim.api.nvim_set_hl(
      0, 'GitConflictCurrentLabel',
      { foreground = current_color, bold = true, underline = true, default = true }
    )
    vim.api.nvim_set_hl(
      0, 'GitConflictIncomingLabel',
      { foreground = incoming_color, bold = true, underline = true, default = true }
    )
    vim.api.nvim_set_hl(
      0, 'GitConflictAncestorLabel',
      { foreground = ancestor_color, bold = true, underline = true, default = true }
    )

    require("git-conflict").setup({})
  end
}
