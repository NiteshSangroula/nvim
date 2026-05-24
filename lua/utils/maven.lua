local M = {}

local term = require("utils.terminal")

function M.test_current()
    local file = vim.fn.expand("%:t:r")
    term.run("mvn -Dtest=" .. file .. " test")
end

function M.test_all()
    term.run("mvn test")
end

function M.clean_install()
    term.run("mvn clean install")
end

return M
