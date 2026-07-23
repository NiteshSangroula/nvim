-- lua/plugins/ui.lua
return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      style = "moon", -- storm, moon, night, day
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        -- annotations tend to blend with keywords by default, so give them
        -- their own distinct color here
        hl["@attribute.java"] = { fg = c.orange, bold = true }
        hl["@attribute"] = { fg = c.orange, bold = true }
      end,
    },
    init = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
