local ok, chat = pcall(require, "CopilotChat")
if not ok then
    return
end

chat.setup({
    window = {
        layout = "vertical",
        width = 0.4, -- 30% sidebar
    },

    auto_insert_mode = true,

    prompts = {
        Explain = "Explain this code clearly and simply",
        Fix = "Fix bugs in this code",
        Optimize = "Optimize this code for performance",
        Clean = "Rewrite this code in a clean and idiomatic way",
    },
})

-- ===== Keymaps =====

local keymap = vim.keymap.set

-- Toggle chat (main entry point)
keymap("n", "<leader>cc", function()
    chat.toggle()
end, { desc = "Toggle Copilot Chat" })

-- Ask about current file
keymap("n", "<leader>ce", function()
    chat.ask("Explain this file")
end, { desc = "Explain file" })

-- ===== Visual mode (best workflow) =====

keymap("v", "<leader>ce", function()
    chat.ask("Explain this code")
end, { desc = "Explain selection" })

keymap("v", "<leader>cf", function()
    chat.ask("Fix this code")
end, { desc = "Fix selection" })

keymap("v", "<leader>co", function()
    chat.ask("Optimize this code")
end, { desc = "Optimize selection" })

keymap("v", "<leader>cr", function()
    chat.ask("Refactor this code")
end, { desc = "Refactor selection" })
