return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                install_dir = vim.fn.stdpath("data") .. "/site",
            })

            -- Install parsers for your languages
            require("nvim-treesitter").install({
                "lua", "java", "c", "cpp", "python",
                "javascript", "typescript",
                "html", "css", "json", "yaml",
                "bash", "markdown", "markdown_inline",
                "vim", "vimdoc",
            })
        end,
    },

    -- textobjects and context still work, they just need queries to exist
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        opts = {
            max_lines = 3,
            trim_scope = "outer",
        },
        keys = {
            { "<leader>tc", "<cmd>TSContextToggle<CR>", desc = "Toggle treesitter context" },
        },
    },
}
