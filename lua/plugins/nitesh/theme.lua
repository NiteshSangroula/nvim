return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.o.background = "dark" -- or "light" if you prefer

        -- Tokyonight settings (optional)
        vim.g.tokyonight_style = "storm" -- "storm", "night", "moon", "day"
        vim.g.tokyonight_transparent = false
        vim.g.tokyonight_enable_italic = true

        -- Apply colorscheme
        vim.cmd("colorscheme tokyonight")
    end,
}
