-- lua/plugins/init.lua

-- Setup Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  { import = 'plugins.nvim-tree' },
  { import = 'plugins.undotree' },
  { import = 'plugins.lualine' },
  { import = 'plugins.telescope' },
})
