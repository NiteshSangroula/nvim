--leader
vim.g.mapleader = " " 


vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

-- nvim tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "Refresh File Explorer" })
vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { desc = "Find File in Explorer" })

-- undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- telescope
vim.keymap.set("n", "<leader>pf", ":Telescope find_files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<C-p>", ":Telescope git_files<CR>", { desc = "Git Files" })
vim.keymap.set("n", "<leader>ps", ":Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>vh", ":Telescope help_tags<CR>", { desc = "Help Tags" })
