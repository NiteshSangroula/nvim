-- lua/plugins/editor.lua
return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- faster native sorter, big difference on large projects
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>",           desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",            desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",              desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",            desc = "Help tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",             desc = "Recent files" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>",          desc = "Diagnostics" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          prompt_prefix        = " ",
          selection_caret      = " ",
          path_display         = { "smart" },
          layout_config        = {
            horizontal = { preview_width = 0.6 },
          },
          -- ignore these in all pickers
          file_ignore_patterns = {
            "%.git/",
            "node_modules/",
            "%.class", -- java compiled files
            "target/", -- maven build output
          },
        },
      })

      -- load fzf extension after setup
      telescope.load_extension("fzf")
    end,
  },

  -- File explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- lazy = false if you want it as your default explorer from the start
    -- otherwise it loads on first use via keys
    keys = {
      {
        "_",
        "<cmd>Oil<cr>",
        desc = "Open parent directory (Oil)",
      },
      {
        "<leader>_",
        function() require("oil").open(vim.fn.expand("%:p:h")) end,
        desc = "Oil (current file dir)",
      },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["q"]     = "actions.close",
        ["<C-h>"] = false, -- free up your window nav keymaps
        ["<C-l>"] = false,
      },
      columns = { "icon" },
      skip_confirm_for_simple_edits = true,
    },
  },

  -- Git signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            silent = true,
            desc = "Git: " .. desc
          })
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Prev hunk")

        -- Actions
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gb", gs.blame_line, "Blame line")
        map("n", "<leader>gd", gs.diffthis, "Diff this")

        -- Stage/reset in visual mode (selected lines only)
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage selected hunk")
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset selected hunk")
      end,
    },
  },
}
