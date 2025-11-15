local M = {}

-- Detect OS
local home = vim.fn.expand("~")
local mason_path = vim.fn.stdpath("data") .. "/mason"

local jdtls_path = mason_path .. "/packages/jdtls"
local lombok_path = home .. "/.local/share/lombok/lombok.jar"

-- JAR launcher for jdtls
local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

M.get_config = function(root_dir)
    local workspace = home .. "/.local/share/jdtls-workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    -- 🔥 Add capabilities
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    return {
        cmd = {
            "java",

            "-javaagent:" .. lombok_path,
            "-Xbootclasspath/a:" .. lombok_path,

            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",

            "-jar", launcher,
            "-configuration", jdtls_path .. "/config_linux",

            "-data", workspace,
        },

        root_dir = root_dir,

        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" }, -- decompiler
                completion = {
                    favoriteStaticMembers = {
                        "org.junit.Assert.*",
                        "org.mockito.Mockito.*",
                    },
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                import = {
                    maven = { enabled = true },
                    gradle = { enabled = true },
                },

                configuration = {
                    updateBuildConfiguration = "automatic",
                },
            },
        },

        -- 🔥 Actually enables diagnostics
        on_attach = function(client, bufnr)
            vim.diagnostic.enable(true, { bufnr = bufnr })
        end,

        -- 🔥 Must include capabilities or diagnostics/hover/actions break
        capabilities = capabilities,

        init_options = {
            bundles = {}, -- debugger later
        },
    }
end

return M
