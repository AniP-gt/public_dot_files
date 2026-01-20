return {
  "RRethy/nvim-treesitter-textsubjects",
  event = "BufRead",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local ts_configs = require("nvim-treesitter.configs")
    ts_configs.setup({
      textsubjects = {
        enable = true,
        prev_selection = ",",
        keymaps = {
          ["ic"] = "textsubjects-container-inner",
          ["ac"] = "textsubjects-container-outer",
        },
      },
    })
    vim.keymap.set("o", "i;", "<cmd>normal! i}<cr>", { desc = "Inner container" })
    vim.keymap.set("o", "a;", "<cmd>normal! a}<cr>", { desc = "Outer container" })
  end,
}
