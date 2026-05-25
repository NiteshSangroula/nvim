-- lua/config/commands.lua

-- All user commands registered here in one place.
-- Logic lives in lua/utils/, not here.

local maven = require("utils.maven")

vim.api.nvim_create_user_command("MvnTestCurrent", maven.test_current, { desc = "Maven: test current file" })
vim.api.nvim_create_user_command("MvnTestAll", maven.test_all, { desc = "Maven: test all" })
vim.api.nvim_create_user_command("MvnInstall", maven.clean_install, { desc = "Maven: clean install" })
