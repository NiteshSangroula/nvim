local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function group(name)
  return augroup(name, { clear = true })
end

-- Highlight yank
autocmd("TextYankPost", {
  group = group("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})

-- Trim trailing whitespace
autocmd("BufWritePre", {
  group = group("trim_whitespace"),
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = group("last_cursor_position"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)

    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Indentation
autocmd("FileType", {
  group = group("indent_overrides"),
  pattern = {
    "lua",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "html",
    "css",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})

-- Java settings
autocmd("FileType", {
  group = group("java_settings"),
  pattern = "java",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
    vim.opt_local.colorcolumn = "120"
  end,
})

-- Quick close utility windows
autocmd("FileType", {
  group = group("quick_close"),
  pattern = {
    "help",
    "qf",
    "man",
    "lspinfo",
    "checkhealth",
    "notify",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", {
      buffer = true,
      silent = true,
    })
  end,
})

-- Terminal settings
autocmd("TermOpen", {
  group = group("terminal_settings"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})
