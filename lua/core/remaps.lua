--leader
vim.g.mapleader = " " 


vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", {silent = true})

-- netrw
vim.keymap.set("n", "<leader>pv", ":Explore<CR>", { desc = "File Explorer" })

-- undo tree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- telescope
vim.keymap.set("n", "<leader>pf", ":Telescope find_files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>pb", ":Telescope buffers<CR>", { desc = "Current Buffers" })
vim.keymap.set("n", "<C-p>", ":Telescope git_files<CR>", { desc = "Git Files" })
vim.keymap.set("n", "<leader>ps", ":Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>vh", ":Telescope help_tags<CR>", { desc = "Help Tags" })


-- for compiling java
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("!mkdir -p bin && find src -name '*.java' > sources.txt && javac -d bin @sources.txt")
end, { desc = "Compile all Java sources", silent = true })

-- for running java 
vim.keymap.set("n", "<leader>ru", function()
  local filepath = vim.api.nvim_buf_get_name(0)  -- full path to current file
  local rel = filepath:match(".*/src/(.*)%.java$")
  if not rel then
    print("Not inside src/ or not a .java file")
    return
  end
  local class = rel:gsub("/", ".")  -- convert path to dot notation
  local cmd = string.format("java -cp bin %s", class)

  -- Open a terminal split and run the command
  vim.cmd("belowright split | resize 15 | terminal " .. cmd)
end, { desc = "Run current Java class in terminal", silent = true })


