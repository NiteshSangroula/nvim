-- lua/config/autocmds.lua
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Helper to create augroups cleanly
local function group(name)
  return augroup(name, { clear = true })
end

-- ============================================================
-- Editing Quality of Life
-- ============================================================

-- Highlight yanked text briefly (built-in, very satisfying)
autocmd("TextYankPost", {
  group = group("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
  desc = "Highlight yanked text",
})


-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = group("trim_whitespace"),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos) -- restore cursor position
  end,
  desc = "Trim trailing whitespace on save",
})

-- ============================================================
-- Window Behavior
-- ============================================================

-- Return to last cursor position when reopening a file
autocmd("BufReadPost", {
  group = group("last_cursor_position"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
  desc = "Restore cursor position on file open",
})

-- ============================================================
-- Filetype Specific
-- ============================================================

-- 2-space indent for web files and config files
autocmd("FileType", {
  group = group("indent_overrides"),
  pattern = { "javascript", "typescript", "json", "yaml", "html", "css", "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "2-space indent for web/config files",
})

-- Wrap and spell check in text files
autocmd("FileType", {
  group = group("text_settings"),
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.conceallevel = 2
  end,
  desc = "Wrap and spellcheck for text files",
})

-- Close certain windows with just q
autocmd("FileType", {
  group = group("quick_close"),
  pattern = { "help", "qf", "lspinfo", "man", "checkhealth", "notify" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
  end,
  desc = "Close utility windows with q",
})

-- ============================================================
-- Java Specific (since you use Maven)
-- ============================================================

-- Auto-set Java indent to 4 spaces (in case something overrides it)
autocmd("FileType", {
  group = group("java_settings"),
  pattern = "java",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.colorcolumn = "120" -- Java convention is usually 120
  end,
  desc = "Java indent and column settings",
})

-- ============================================================
-- Terminal
-- ============================================================

-- No line numbers in terminal, start in insert mode
autocmd("TermOpen", {
  group = group("terminal_settings"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
  desc = "Clean terminal appearance",
})

-- Enable treesitter highlighting
autocmd("FileType", {
  group = group("treesitter_highlight"),
  pattern = {
    "lua", "java", "c", "cpp", "python",
    "javascript", "typescript",
    "html", "css", "json", "yaml",
    "bash", "markdown",
  },
  callback = function()
    vim.treesitter.start()
  end,
  desc = "Enable treesitter highlighting",
})
