-- lua/plugins/ui.lua
return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            terminal_colors = true,
        },
        init = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        opts = {
            flavour = "mocha",
        },
        -- init only on the one you want active, comment/uncomment to switch
        -- init = function()
        --     vim.cmd.colorscheme("catppuccin")
        -- end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        lazy = true,
        opts = {
            contrast = "hard",
        },
        -- init = function()
        --     vim.cmd.colorscheme("gruvbox")
        -- end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
}
