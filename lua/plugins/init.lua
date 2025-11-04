return {
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      require("plugins.theme")
    end
  },

  { "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugins.telescope")
    end
  },

  { "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.nvimtree")
    end
  },

  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("plugins.treesitter")
    end
  },

  { "mbbill/undotree",
    config = function()
      require("plugins.undotree")
    end
  },
}
