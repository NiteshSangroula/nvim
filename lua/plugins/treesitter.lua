require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "python", "javascript", "html", "css", "c", "cpp", "java", "bash", "json", "markdown"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
  auto_install = true,
})

