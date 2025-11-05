-- ===============================
-- 🌐 LSP Setup (Modern Neovim)
-- ===============================

-- --- Mason setup ---
require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "pyright" },
})

-- --- nvim-cmp integration ---
local capabilities = require("cmp_nvim_lsp").default_capabilities()


-- --- Global LSP config (applies to all servers) ---
vim.lsp.config("*", {
    capabilities = capabilities,
})

-- --- Language-specific settings ---
-- lua ls
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

-- clangd
vim.lsp.config("clangd", {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    root_markers = { ".clangd", "compile_commands.json", ".git" },
    capabilities = capabilities,
    -- You can leave this empty if defaults are fine
})

vim.diagnostic.config({
    virtual_text = { prefix = "●", spacing = 2 },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user.lsp", {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf

        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        -- Navigation + Actions
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "K", vim.lsp.buf.hover, "Hover info")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

        -- Formatting (on save)
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1000 })
                end,
            })
        end

        -- 🧩 Auto-refresh diagnostics
        vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
            buffer = bufnr,
            callback = function()
                vim.diagnostic.show(nil, bufnr)
            end,
        })
    end,
})

-- --- Automatically start installed servers ---
local mason_lsp = require("mason-lspconfig")
for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
    vim.lsp.start({ name = server_name })
end
