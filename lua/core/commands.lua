local M = {}

function M.mvn_test_current()
    local file = vim.fn.expand("%:t:r") -- LibraryTest
    local cmd = "mvn -Dtest=" .. file .. " test"
    vim.cmd("split | terminal " .. cmd)
end

vim.api.nvim_create_user_command(
    "MvnTestCurrent",
    M.mvn_test_current,
    {}
)

return M
