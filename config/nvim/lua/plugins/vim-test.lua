return {
  "vim-test/vim-test",
  dependencies = {
    "akinsho/toggleterm.nvim",
  },
  keys = {
    { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
    -- { "<leader>tf", "<cmd>TestFile<cr>", desc = "Test file" },
    { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
    { "<leader>tl", "<cmd>TestLast<cr>", desc = "Test last" },
    { "<leader>tv", "<cmd>TestVisit<cr>", desc = "Visit test file" },
  },
  config = function()
    -- Use ToggleTerm for test output
    vim.g["test#strategy"] = "toggleterm"

    -- Configure test runners
    vim.g["test#ruby#rspec#executable"] = "bundle exec rspec"
    vim.g["test#javascript#jest#executable"] = "npm test"

    -- Optional: Set ToggleTerm direction for tests
    vim.g["test#neovim#term_position"] = "below 15"
  end,
}

