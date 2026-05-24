-- Set leader keys FIRST (before anything else)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


require("config.options")
require("config.commands")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")
