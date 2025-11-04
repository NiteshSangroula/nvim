-- ~/.config/nvim/lua/plugins/telescope.lua
local telescope = require("telescope")

telescope.setup({
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    layout_config = { horizontal = { preview_width = 0.6 } },
  },
})

-- Keymaps
local map = vim.keymap.set
local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)

