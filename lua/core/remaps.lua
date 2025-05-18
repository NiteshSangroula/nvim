--leader
vim.g.mapleader = " " 


vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

-- nvim tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh File Explorer" })
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { desc = "Find File in Explorer" })
