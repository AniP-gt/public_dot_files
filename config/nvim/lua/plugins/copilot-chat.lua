return {
  "CopilotC-Nvim/CopilotChat.nvim",
  enabled = true, -- Disable temporarily to test if this is causing transport warnings
  branch = "main",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
  },
  build = "make tiktoken",
  opts = {
    debug = false,
    model = "gpt-4",
    temperature = 0.1,
    window = {
      layout = "vertical",
      width = 0.3,
      height = 0.5,
      relative = "editor",
    },
    -- Suppress warnings
    log_level = "error",
    show_folds = false,
  },
  keys = {
    { "<leader>cc", ":CopilotChat<CR>", desc = "Open Copilot Chat" },
    { "<leader>cc", ":CopilotChat<CR>", mode = "v", desc = "Open Copilot Chat with selection" },
    { "<leader>ccq", function() require("CopilotChat").close() end, desc = "Close Copilot Chat" },
    { "<leader>ccr", function() require("CopilotChat").reset() end, desc = "Reset Copilot Chat" },
    { "<leader>cai", function() require("CopilotChat").ask("Optimize this code for better performance.", { selection = require("CopilotChat.select").visual }) end, mode = "v", desc = "AI: Optimize code" },
    { "<leader>cfd", function() require("CopilotChat").ask("Fix the diagnostic issues in this code.", { selection = require("CopilotChat.select").buffer }) end, desc = "Fix diagnostics" },
    { "<leader>cco", function() require("CopilotChat").ask("Write a commit message for the current changes.") end, desc = "Generate commit message" },
    { "<leader>cs", function() require("CopilotChat").ask("Write a commit message for the staged changes.") end, desc = "Generate staged commit message" },
    { "<leader>ce", function() require("CopilotChat").ask("Explain how this code works.", { selection = require("CopilotChat.select").visual }) end, mode = "v", desc = "Explain code" },
    { "<leader>car", function() require("CopilotChat").ask("Review this code and suggest improvements.", { selection = require("CopilotChat.select").visual }) end, mode = "v", desc = "AI: Review code" },
    { "<leader>caf", function() require("CopilotChat").ask("Fix the bugs in this code.", { selection = require("CopilotChat.select").visual }) end, mode = "v", desc = "AI: Fix code" },
    { "<leader>cd", function() require("CopilotChat").ask("Generate documentation for this code.", { selection = require("CopilotChat.select").visual }) end, mode = "v", desc = "Document code" },
    { "<leader>ct", function() require("CopilotChat").ask("Generate tests for this code.", { selection = require("CopilotChat.select").visual }) end, mode = "v", desc = "Generate tests" },
  },
  config = function(_, opts)
    require("CopilotChat").setup(opts)
  end,
}
