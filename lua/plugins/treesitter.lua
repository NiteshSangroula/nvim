return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- Install parsers for your languages
      require("nvim-treesitter").install({
        "lua", "java", "c", "cpp", "python",
        "javascript", "typescript",
        "html", "css", "json", "yaml",
        "bash", "markdown", "markdown_inline",
        "vim", "vimdoc",
      })
    end,
  },

  -- textobjects and context still work, they just need queries to exist
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    branch = "main",

    config = function()
      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

      --------------------------------------------------
      -- SELECT TEXTOBJECTS
      --------------------------------------------------

      -- functions
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end)

      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end)

      -- classes
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end)

      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner", "textobjects")
      end)

      -- parameters
      vim.keymap.set({ "x", "o" }, "aa", function()
        select.select_textobject("@parameter.outer", "textobjects")
      end)

      vim.keymap.set({ "x", "o" }, "ia", function()
        select.select_textobject("@parameter.inner", "textobjects")
      end)

      --------------------------------------------------
      -- MOVEMENT
      --------------------------------------------------

      -- next function start
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
      end)

      -- previous function start
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end)

      -- next class
      vim.keymap.set({ "n", "x", "o" }, "]]", function()
        move.goto_next_start("@class.outer", "textobjects")
      end)

      -- previous class
      vim.keymap.set({ "n", "x", "o" }, "[[", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end)

      --------------------------------------------------
      -- REPEATABLE MOTIONS
      --------------------------------------------------

      vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", repeat_move.repeat_last_move_previous)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      max_lines = 3,
      trim_scope = "outer",
    },
    keys = {
      { "<leader>tc", "<cmd>TSContext toggle<CR>", desc = "Toggle treesitter context" },
    },
  },
}
