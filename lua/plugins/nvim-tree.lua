

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional icons
  config = function()
    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        highlight_opened_files = "name",
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
          },
        },
      },
      filters = {
        dotfiles = false, -- Show hidden files
        custom = { "^.git$" }, -- Hide git folder
      },
      git = {
        enable = true,
        ignore = false,
      },
    })
  end,
}
