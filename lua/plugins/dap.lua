return {
  -- Core DAP engine
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- required by dap-ui
      "theHamsta/nvim-dap-virtual-text",
      "williamboman/mason.nvim",
    },
    keys = {
      -- Breakpoints
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                         desc = "DAP: Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP: Conditional breakpoint" },

      -- Session control
      { "<leader>dc", function() require("dap").continue() end,                                  desc = "DAP: Continue" },
      { "<leader>dn", function() require("dap").step_over() end,                                 desc = "DAP: Step over" },
      { "<leader>di", function() require("dap").step_into() end,                                 desc = "DAP: Step into" },
      { "<leader>do", function() require("dap").step_out() end,                                  desc = "DAP: Step out" },
      { "<leader>dq", function() require("dap").terminate() end,                                 desc = "DAP: Terminate" },
      { "<leader>dr", function() require("dap").restart() end,                                   desc = "DAP: Restart" },

      -- UI
      { "<leader>du", function() require("dapui").toggle() end,                                  desc = "DAP: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end,                                    desc = "DAP: Eval expression",       mode = { "n", "v" } },
    },
    config = function()
      local dap   = require("dap")
      local dapui = require("dapui")

      -- --------------------------------------------------------
      -- DAP UI setup
      -- --------------------------------------------------------
      dapui.setup({
        icons = { expanded = "", collapsed = "", current_frame = "" },
        layouts = {
          {
            -- left side panel
            elements = {
              { id = "scopes",      size = 0.4 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks",      size = 0.2 },
              { id = "watches",     size = 0.2 },
            },
            size = 40,
            position = "left",
          },
          {
            -- bottom panel
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12,
            position = "bottom",
          },
        },
      })

      -- Auto open/close UI when session starts/ends
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

      -- --------------------------------------------------------
      -- Virtual text (show variable values inline)
      -- --------------------------------------------------------
      require("nvim-dap-virtual-text").setup({
        commented = true, -- show virtual text as a comment
      })

      -- --------------------------------------------------------
      -- C / C++ adapter (codelldb via mason)
      -- --------------------------------------------------------
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
      local codelldb_path = mason_path .. "/codelldb/extension/adapter/codelldb"

      dap.adapters.codelldb = {
        type       = "server",
        port       = "${port}",
        executable = {
          command = codelldb_path,
          args    = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name        = "Launch file",
          type        = "codelldb",
          request     = "launch",
          program     = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      -- C++ uses same config as C
      dap.configurations.cpp = dap.configurations.c

      --[[
            -- --------------------------------------------------------
            -- Python adapter (debugpy via mason)
            -- --------------------------------------------------------
            local debugpy_path = mason_path .. "/debugpy/venv/bin/python"

            dap.adapters.python = {
                type    = "executable",
                command = debugpy_path,
                args    = { "-m", "debugpy.adapter" },
            }

            dap.configurations.python = {
                {
                    name    = "Launch file",
                    type    = "python",
                    request = "launch",
                    program = "${file}",
                    console = "integratedTerminal",
                    justMyCode = true,
                },
            }
        ]] --
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    lazy = true, -- loaded by nvim-dap as dependency
  },

  -- Inline variable values
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
  },
}
