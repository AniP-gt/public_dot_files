return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" },
  event = { "BufReadPost", "BufNewFile" },
  config = true,
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
    { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX<cr>", desc = "Find TODO/FIX" },
    { "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Todo quickfix list" },
    { "<leader>tl", "<cmd>TodoLocList<cr>", desc = "TODO location list" },
  },
}
