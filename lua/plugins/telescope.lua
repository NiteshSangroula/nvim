-- ~/.config/nvim/lua/plugins/telescope.lua
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        layout_config = { horizontal = { preview_width = 0.6 } },
    },
})

-- Keymaps
local map = vim.keymap.set
local builtin_ok, builtin = pcall(require, "telescope.builtin")
if not builtin_ok then
    return
end

local opts = { noremap = true, silent = true }
map("n", "<leader>ff", builtin.find_files, opts)
map("n", "<leader>fg", builtin.live_grep, opts)
map("n", "<leader>fb", builtin.buffers, opts)
map("n", "<leader>fh", builtin.help_tags, opts)
