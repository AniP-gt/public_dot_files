return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = {
    { "<leader>M", "<cmd>Mason<cr>", desc = "Mason" },
  },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
