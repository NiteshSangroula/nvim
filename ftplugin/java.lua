local jdtls = require("jdtls")
local java_config = require("plugins.lsp.java")

-- Find project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls.setup.find_root(root_markers)

if root_dir == "" then
    return
end

local config = java_config.get_config(root_dir)

jdtls.start_or_attach(config)

-- Optional: keymaps
vim.keymap.set("n", "<leader>oi", jdtls.organize_imports)
vim.keymap.set("n", "<leader>rv", jdtls.extract_variable)
vim.keymap.set("n", "<leader>rm", jdtls.extract_method)
vim.keymap.set("n", "<leader>rc", jdtls.extract_constant)
