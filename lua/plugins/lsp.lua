return {
  -- Mason: LSP installer
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = { border = "rounded" },
    },
  },

  -- Bridges mason + lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
      },
      automatic_enable = {
        exclude = { "jdtls" },
      },
    },
  },

  -- Core LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      -- --------------------------------------------------------
      -- Server settings
      -- To add a new language:
      --   1. add server name to mason ensure_installed above
      --   2. add vim.lsp.config block here if needed (optional)
      -- --------------------------------------------------------
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--offset-encoding=utf-16",
        },
        root_markers = { ".clangd", "compile_commands.json", ".git" },
      })

      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- --------------------------------------------------------
      -- Diagnostics
      -- --------------------------------------------------------
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 2,
          source = "if_many",
        },
        float = {
          border = "rounded",
          source = true,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- --------------------------------------------------------
      -- Keymaps on attach
      -- --------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user.lsp", { clear = true }),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              buffer = bufnr,
              silent = true,
              desc = "LSP: " .. desc,
            })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gr", vim.lsp.buf.references, "Find references")
          map("n", "K", vim.lsp.buf.hover, "Hover info")
          map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("v", "<leader>ca", vim.lsp.buf.code_action, "Code action (range)")
          map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
          --map("n", "]d", vim.diagnostic.get_next, "Next diagnostic")
          --map("n", "[d", vim.diagnostic.get_prev, "Prev diagnostic")

          -- Inlay hints toggle (Neovim 0.10+, optional but zero cost)
          if client:supports_method("textDocument/inlayHint") then
            map("n", "<leader>lh", function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }),
                { bufnr = bufnr }
              )
            end, "Toggle inlay hints")
          end
        end,
      })
    end,
  },

  -- Lua LSP awareness of vim.* API
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- only loads when opening a java file
  },
}
