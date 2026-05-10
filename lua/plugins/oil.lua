require("oil").setup({
  default_file_explorer = true,

  view_options = {
    show_hidden = true,
  },

  keymaps = {
    ["q"] = "actions.close",
    ["<C-h>"] = false,
    ["<C-l>"] = false,
  },

  columns = {
    "icon",
  },

  skip_confirm_for_simple_edits = true,
})
