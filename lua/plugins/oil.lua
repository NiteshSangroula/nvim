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


-- for oil
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory (Oil)" })

vim.keymap.set("n", "<leader>-", function()
    require("oil").open(vim.fn.expand("%:p:h"))
end, { desc = "Oil (current file dir)" })
