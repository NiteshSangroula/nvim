local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "<C-c>", "<Esc>", opts)

-- Basic navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- for bufferline
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")

-- for oil
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory (Oil)" })

vim.keymap.set("n", "<leader>-", function()
    require("oil").open(vim.fn.expand("%:p:h"))
end, { desc = "Oil (current file dir)" })

-- for java test
vim.keymap.set("n", "<leader>t", ":MvnTestCurrent<CR>", { noremap = true, silent = true })
