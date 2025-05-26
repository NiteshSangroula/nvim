return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },

  },
  config = function()
    local lspconfig = require("lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    local opts = { noremap = true, silent = true }
    
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definition"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definition<CR>", opts)

      opts.desc = "Show LSP implementation"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      keymap.set( {"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = "", Warn = "", Hint = "󰰂", Info="" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl="" })
    end

    -- diagnostic

    vim.diagnostic.config({
      virtual_text = {
        prefix = '●', -- or ">>", "●", "■", etc.
        spacing = 2,
      },
      signs = true,
      underline = true,
      update_in_insert = false, -- diagnostics only after you leave insert mode
      severity_sort = true,
    })




    -- configure lsp
    -- html
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,

    })

    -- javascript
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,

    })

    -- css
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,

    })

    -- lua
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,

      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },

    })

    -- java
    lspconfig["jdtls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,

    })
  end,
}
