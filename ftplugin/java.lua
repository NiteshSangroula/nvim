-- ftplugin/java.lua
local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("nvim-jdtls not installed", vim.log.levels.WARN)
  return
end

-- --------------------------------------------------------
-- Paths
-- --------------------------------------------------------
local mason_path   = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path   = mason_path .. "/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local lombok_jar   = jdtls_path .. "/lombok.jar"

-- OS detection
local os_config    = "config_linux"
if vim.fn.has("mac") == 1 then
  os_config = "config_mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "config_win"
end
local config_dir   = jdtls_path .. "/" .. os_config

-- --------------------------------------------------------
-- Project root + workspace
-- --------------------------------------------------------
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir     = require("jdtls.setup").find_root(root_markers)
if not root_dir then return end

local project_name    = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir   = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

-- --------------------------------------------------------
-- DAP bundles (added here, right after paths)
-- --------------------------------------------------------
local bundles         = {}

local java_debug_path = vim.fn.glob(
  mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
)
if java_debug_path ~= "" then
  table.insert(bundles, java_debug_path)
end

local java_test_path = vim.fn.glob(
  mason_path .. "/vscode-java-test/extension/server/*.jar"
)
if java_test_path ~= "" then
  vim.list_extend(bundles, vim.split(java_test_path, "\n", { trimempty = true }))
end

-- --------------------------------------------------------
-- Capabilities
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
  cmd          = {
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

  root_dir     = root_dir,
  capabilities = capabilities,

  settings     = {
    java = {
      eclipse                 = { downloadSources = true },
      maven                   = { downloadSources = true },
      configuration           = {
        updateBuildConfiguration = "interactive",
      },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens      = { enabled = true },
      references              = { includeDecompiledSources = true },
      format                  = { enabled = true },
      inlayHints              = {
        parameterNames = { enabled = "all" },
      },
    },
  },

  -- bundles now populated instead of empty
  init_options = {
    bundles = bundles,
  },

  on_attach    = function(client, bufnr)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        silent = true,
        desc = "Java: " .. desc,
      })
    end

    -- Java refactor actions
    map("n", "<leader>jo", jdtls.organize_imports, "Organize imports")
    map("n", "<leader>jv", jdtls.extract_variable, "Extract variable")
    map("n", "<leader>jc", jdtls.extract_constant, "Extract constant")
    map("v", "<leader>jm", function()
      jdtls.extract_method(true)
    end, "Extract method")

    -- Maven
    map("n", "<leader>jt", "<cmd>MvnTestCurrent<CR>", "Maven test current")
    map("n", "<leader>jT", "<cmd>MvnTestAll<CR>", "Maven test all")
    map("n", "<leader>ji", "<cmd>MvnInstall<CR>", "Maven clean install")

    -- DAP (only set up if nvim-dap is available)
    local ok_dap, dap = pcall(require, "dap")
    if ok_dap then
      -- enable jdtls dap -- this is what activates the debug bundles
      jdtls.setup_dap({ hotcodereplace = "auto" })
      require("jdtls.dap").setup_dap_main_class_configs()

      map("n", "<leader>jd", jdtls.test_nearest_method, "Debug nearest method")
      map("n", "<leader>jD", jdtls.test_class, "Debug test class")
      map("n", "<leader>jS", function()
        dap.continue()
      end, "Start debug session")
    end
  end,
}

jdtls.start_or_attach(config)
