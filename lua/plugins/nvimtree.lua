-- ~/.config/nvim/lua/plugins/nvimtree.lua
require("nvim-tree").setup({
  view = {
    width = 35,
    side = "left",
    relativenumber = true,
  },
  renderer = {
    highlight_git = true,
    indent_markers = { enable = true },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },
})

-- Keymap
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

