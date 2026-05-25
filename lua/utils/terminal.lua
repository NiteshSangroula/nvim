local M = {}

-- Reusable terminal runner — all your utils call this
function M.run(cmd, opts)
    opts = opts or {}
    local direction = opts.direction or "split" -- "split" | "vsplit" | "tabnew"
    local size = opts.size or 15

    vim.cmd(direction)
    vim.cmd("terminal " .. cmd)
    vim.cmd("resize " .. size)

    -- Drop into insert mode so you can interact with the terminal
    vim.cmd("startinsert")
end

return M
