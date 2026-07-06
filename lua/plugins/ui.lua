-- lua/plugins/ui.lua
return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      contrast = "hard",
      transparent_mode = true,
    },
    init = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
