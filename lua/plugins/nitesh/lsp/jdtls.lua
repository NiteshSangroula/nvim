return {
  "mfussenegger/nvim-jdtls",
  ft = "java",

  config = function()
    local jdtls = require("jdtls")
    local home = vim.env.HOME
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = home .. "/.local/share/eclipse/" .. project_name

    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "src" }
    local root_dir = require("jdtls.setup").find_root(root_markers)

    if not root_dir then return end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local config = {
      cmd = { "jdtls", "-data", workspace_dir },
      root_dir = root_dir,
      capabilities = capabilities,

      on_attach = function(client, bufnr)
        require("jdtls.setup").add_commands()
        require("jdtls.dap").setup_dap_main_class_configs()

        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
        map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("n", "gR", vim.lsp.buf.references, "Go to References")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      end,
    }

    -- Auto attach jdtls for every Java buffer opened in this root
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = function()
        local current_root = require("jdtls.setup").find_root(root_markers)
        if current_root and current_root == root_dir then
          jdtls.start_or_attach(config)
        end
      end,
    })
  end,
}
