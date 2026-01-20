return {
  "kazhala/close-buffers.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>bD", "<cmd>BDelete this<cr>", desc = "Delete current buffer" },
    { "<leader>bO", "<cmd>BDelete other<cr>", desc = "Delete all other buffers" },
    { "<leader>bH", "<cmd>BDelete hidden<cr>", desc = "Delete all hidden buffers" },
    { "<leader>bA", "<cmd>BDelete all<cr>", desc = "Delete all buffers" },
    { "<leader>bN", "<cmd>BDelete nameless<cr>", desc = "Delete nameless buffers" },
    { "<leader>bP", "<cmd>BWipeout this<cr>", desc = "Wipeout current buffer" },
  },
}
