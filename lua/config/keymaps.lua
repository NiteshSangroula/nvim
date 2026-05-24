-- lua/config/keymaps.lua
local map = vim.keymap.set

-- ============================================================
-- Helper: reusable default opts, but with desc support
-- ============================================================
local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- ============================================================
-- Insert Mode
-- ============================================================
map("i", "<C-c>", "<Esc>", opts("Escape insert mode"))

-- ============================================================
-- Better Navigation
-- ============================================================
map("n", "<C-h>", "<C-w>h", opts("Window left"))
map("n", "<C-j>", "<C-w>j", opts("Window down"))
map("n", "<C-k>", "<C-w>k", opts("Window up"))
map("n", "<C-l>", "<C-w>l", opts("Window right"))

-- Move lines up/down in visual mode (very handy)
map("v", "J", ":m '>+1<CR>gv=gv", opts("Move line down"))
map("v", "K", ":m '<-2<CR>gv=gv", opts("Move line up"))

-- Keep cursor centered when jumping / searching
map("n", "<C-d>", "<C-d>zz", opts("Scroll down centered"))
map("n", "<C-u>", "<C-u>zz", opts("Scroll up centered"))
map("n", "n", "nzzzv", opts("Next search result centered"))
map("n", "N", "Nzzzv", opts("Prev search result centered"))

-- ============================================================
-- Editing Quality of Life
-- ============================================================
-- Paste without losing the register (paste over selection)
map("x", "<leader>p", '"_dP', opts("Paste without yanking"))

-- Delete without touching yank register
map({ "n", "v" }, "<leader>d", '"_d', opts("Delete without yanking"))

-- Keep visual selection after indent
map("v", "<", "<gv", opts("Indent left"))
map("v", ">", ">gv", opts("Indent right"))

-- ============================================================
-- Buffers
-- ============================================================
map("n", "<leader>bd", "<cmd>bd<CR>", opts("Close buffer"))
map("n", "]b", "<cmd>bnext<CR>", opts("Next buffer"))
map("n", "[b", "<cmd>bprev<CR>", opts("Prev buffer"))

-- ============================================================
-- Quickfix (great with LSP and grep)
-- ============================================================
map("n", "]q", "<cmd>cnext<CR>zz", opts("Next quickfix"))
map("n", "[q", "<cmd>cprev<CR>zz", opts("Prev quickfix"))
map("n", "<leader>qo", "<cmd>copen<CR>", opts("Open quickfix list"))
map("n", "<leader>qc", "<cmd>cclose<CR>", opts("Close quickfix list"))

-- ============================================================
-- Misc
-- ============================================================
-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", opts("Clear search highlight"))

-- Don't jump on * (search word under cursor without moving)
map("n", "*", "*N", opts("Search word, stay put"))

-- ============================================================
-- Java / Project specific
-- ============================================================
map("n", "<leader>t", "<cmd>MvnTestCurrent<CR>", opts("Maven: test current"))
