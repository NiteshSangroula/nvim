-- lua/config/options.lua
local opt = vim.opt

-- === Line Numbers ===
opt.number = true
opt.relativenumber = true

-- === Mouse and Clipboard ===
opt.mouse = ""
opt.clipboard = "unnamedplus"

-- === Indentation ===
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- === Appearance ===
opt.wrap = false
opt.termguicolors = true
opt.cursorline = false
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.sidescrolloff = 8   -- NEW: horizontal breathing room when wrap=false
opt.colorcolumn = "100" -- NEW: visual ruler (remove if you find it annoying)
opt.showmode = false    -- NEW: hides "-- INSERT --" (redundant if you have a statusline)
opt.pumheight = 10      -- NEW: max items in completion popup

-- === Splits ===
opt.splitbelow = true
opt.splitright = true

-- === Files ===
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.autoread = true -- NEW reload file if changed outside nvim

-- === Search ===
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true

-- === Performance ===
opt.updatetime = 250 -- NEW: faster CursorHold events (default 4000ms is too slow)
opt.timeoutlen = 300 -- NEW: faster which-key popup response

-- === Misc ===
opt.conceallevel = 0       -- NEW: show actual characters (important for markdown/json)
opt.fileencoding = "utf-8" -- NEW: explicit encoding
opt.confirm = true         -- NEW: asks "save?" instead of failing on :q with unsaved changes
opt.virtualedit = "block"  -- NEW: allows cursor to move freely in visual block mode
