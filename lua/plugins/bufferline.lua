require("bufferline").setup({
    options = {
        mode = "buffers", -- important: keeps it simple (not tabs)
        numbers = "none",

        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",

        indicator = {
            style = "underline",
        },

        diagnostics = "nvim_lsp",

        separator_style = "slant",

        show_buffer_close_icons = false,
        show_close_icon = false,

        always_show_bufferline = true,

        sort_by = "insert_after_current",
    },
})


-- for bufferline
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
