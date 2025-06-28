
return {
    -- Gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")
        end,
    },

    -- Just add this if you want to switch later
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = true,
    },

    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
        lazy = true
    },
}
