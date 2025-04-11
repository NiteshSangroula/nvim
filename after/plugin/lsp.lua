local lsp_zero = require('lsp-zero')

lsp_zero.extend_lspconfig()

-- Ensure required LSPs are installed
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { "lua_ls", "omnisharp" },
    automatic_installation = true,
})

-- Setup LSP configurations
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        },
    },
})

lspconfig.omnisharp.setup({
    cmd = { "omnisharp" },
    root_dir = lspconfig.util.root_pattern("*.sln", ".git"),
    enable_editorconfig_support = true,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
})

-- Customize LSP behavior
lsp_zero.set_sign_icons({
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
})

-- Configure diagnostics
vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = true,
})

lsp_zero.setup()
