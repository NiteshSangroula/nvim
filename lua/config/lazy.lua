-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap lazy.nvim if not installed
if not vim.uv.fs_stat(lazypath) then -- vim.uv instead of vim.loop (loop is deprecated)
  vim.notify("Installing lazy.nvim...", vim.log.levels.INFO)
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { -- pass the folder name as string, not require("plugins")
  defaults = {
    lazy = true,                   -- lazy-load everything by default
  },
  install = {
    colorscheme = { "habamax" },     -- fallback colorscheme during install
  },
  checker = {
    enabled = true,     -- auto-check for plugin updates
    notify = false,     -- silently check, don't pop up every time
  },
  change_detection = {
    notify = false,     -- don't notify when config files change
  },
  ui = {
    border = "rounded",     -- nicer lazy UI
  },
  performance = {
    rtp = {
      disabled_plugins = {       -- disable unused built-in plugins for faster startup
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",         -- if you use oil.nvim or neo-tree
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
