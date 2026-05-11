local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("nvim-treesitter not installed yet", vim.log.levels.WARN)
    return
end

configs.setup({
    ensure_installed = {
        "lua", "python", "javascript", "html", "css",
        "c", "cpp", "java", "bash", "json", "markdown"
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    auto_install = true,
})
