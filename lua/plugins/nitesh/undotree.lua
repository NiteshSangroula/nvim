return {
  "mbbill/undotree",
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_ShortIndicator = 1
    vim.g.undotree_SetForceWhenToggle = 1

    local undodir = vim.fn.stdpath("data") .. "/undo"
    vim.fn.mkdir(undodir, "p")
    vim.opt.undodir = undodir
    vim.opt.undofile = true

  end
}
