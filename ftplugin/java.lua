-- ftplugin/java.lua
local ok, jdtls = pcall(require, "jdtls")
if not ok then
    vim.notify("nvim-jdtls not installed", vim.log.levels.WARN)
    return
end

-- --------------------------------------------------------
-- Paths
-- --------------------------------------------------------
local mason_path    = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path    = mason_path .. "/jdtls"
local launcher_jar  = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local lombok_jar    = jdtls_path .. "/lombok.jar"

-- OS detection instead of hardcoding linux
local os_config = "config_linux"
if vim.fn.has("mac") == 1 then
    os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
    os_config = "config_win"
end
local config_dir = jdtls_path .. "/" .. os_config

-- --------------------------------------------------------
-- Project root + workspace
-- --------------------------------------------------------
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir     = require("jdtls.setup").find_root(root_markers)
if not root_dir then return end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

-- --------------------------------------------------------
-- Capabilities (pull from cmp if available)
-- --------------------------------------------------------
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    capabilities = cmp_lsp.default_capabilities()
end

-- --------------------------------------------------------
-- Config
-- --------------------------------------------------------
local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. lombok_jar,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_jar,
        "-configuration", config_dir,
        "-data", workspace_dir,
    },

    root_dir = root_dir,
    capabilities = capabilities,

    settings = {
        java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            references = { includeDecompiledSources = true },
            format = { enabled = true },
            -- inlay hints
            inlayHints = {
                parameterNames = { enabled = "all" },
            },
        },
    },

    init_options = {
        bundles = {},
    },

    -- Java-specific keymaps on attach
    on_attach = function(client, bufnr)
        -- Run the standard LSP keymaps from your lsp.lua first
        -- (LspAttach autocmd fires automatically, this adds Java-only ones)
        local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {
                buffer = bufnr,
                silent = true,
                desc = "Java: " .. desc,
            })
        end

        -- Java-specific actions
        map("<leader>jo", jdtls.organize_imports,          "Organize imports")
        map("<leader>jv", jdtls.extract_variable,          "Extract variable")
        map("<leader>jc", jdtls.extract_constant,          "Extract constant")
        map("<leader>jt", "<cmd>MvnTestCurrent<CR>",       "Maven test current")
        map("<leader>jT", "<cmd>MvnTestAll<CR>",           "Maven test all")
        map("<leader>ji", "<cmd>MvnInstall<CR>",           "Maven clean install")

        -- Extract method works in visual mode too
        vim.keymap.set("v", "<leader>jm", function()
            jdtls.extract_method(true)
        end, { buffer = bufnr, silent = true, desc = "Java: Extract method" })
    end,
}

jdtls.start_or_attach(config)
