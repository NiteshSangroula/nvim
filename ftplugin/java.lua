local jdtls = require("jdtls")

-- Detect project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == nil then
    return
end

-- Workspace directory
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

-- Mason paths
local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
local jdtls_path = mason_path .. "/jdtls"

-- Find the launcher JAR dynamically
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Add Lombok agent (must exist inside jdtls package)
local lombok_jar = jdtls_path .. "/lombok.jar"

-- OS config
local config_dir = jdtls_path .. "/config_linux"

-- Final config
local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",

        "-javaagent:" .. lombok_jar, -- Lombok support

        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",

        "-jar", launcher_jar,
        "-configuration", config_dir,
        "-data", workspace_dir,
    },

    root_dir = root_dir,

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
        }
    },

    init_options = {
        bundles = {}, -- no debugger/test bundles unless you add them later
    },
}

jdtls.start_or_attach(config)
