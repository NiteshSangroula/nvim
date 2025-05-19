
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "→ ",
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        layout_config = {
          horizontal = { preview_width = 0.5 },
          vertical = { preview_height = 0.5 },
        },
        file_ignore_patterns = { "node_modules", ".git/", "dist/", "__pycache__" },
        mappings = {
          i = {
            ["<C-u>"] = false, -- Clear prompt
            ["<C-d>"] = false, -- Scroll down
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- Include hidden files in search
        },
        live_grep = {
          only_sort_text = true, -- Fast text search
        },
      },
    })

    -- Load Telescope Extensions (if any)
    --telescope.load_extension("fzf")
  end,
}

