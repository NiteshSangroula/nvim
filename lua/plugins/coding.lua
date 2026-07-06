-- lua/plugins/coding.lua
return {
  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {},
    config = function()
      require("luasnip").setup({
        -- disable default mappings so C-n/C-p are free
        enable_autosnippets = false,
      })
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completions
      "hrsh7th/cmp-buffer",       -- buffer word completions
      "hrsh7th/cmp-path",         -- filesystem path completions
      "hrsh7th/cmp-cmdline",      -- cmdline completions
      "saadparwaiz1/cmp_luasnip", -- snippet completions
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",     -- icons in completion menu
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- ------------------------------------------------
        -- Mappings
        -- ------------------------------------------------
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),

          -- Confirm with Enter
          ["<CR>"]      = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false, -- only confirm explicitly selected item
          }),

          -- Tab navigates completion, also handles snippets
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        -- ------------------------------------------------
        -- Sources (order = priority)
        -- ------------------------------------------------
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 10 },
          { name = "luasnip",  max_item_count = 5 },
        }, {
          { name = "buffer", max_item_count = 5 },
          { name = "path" },
        }),

        -- ------------------------------------------------
        -- Formatting with icons via lspkind
        -- ------------------------------------------------
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- shows icon + type name
            maxwidth = 40,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snip]",
                buffer   = "[Buf]",
                path     = "[Path]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },

        -- ------------------------------------------------
        -- Appearance
        -- ------------------------------------------------
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- Don't complete in comments
        enabled = function()
          local context = require("cmp.config.context")
          if vim.bo.buftype == "prompt" then
            return false
          end
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          end
          return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
        end,
      })

      -- ------------------------------------------------
      -- Cmdline completion ( / and : )
      -- ------------------------------------------------
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>lf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      -- Formatters per filetype
      -- Add a new language: just add an entry here
      formatters_by_ft = {
        lua        = { "stylua" },
        python     = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html       = { "prettier" },
        css        = { "prettier" },
        json       = { "prettier" },
        yaml       = { "prettier" },
        java       = { "google-java-format" },
        c          = { "clang-format" },
        cpp        = { "clang-format" },
      },
      -- Format on save
      format_on_save = {
        timeout_ms   = 1000,
        lsp_fallback = true, -- fall back to LSP if no formatter defined
      },
    },
  },

  -- Auto close brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({ check_ts = true })

      -- Make cmp and autopairs work together
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done)
    end,
  },
}
