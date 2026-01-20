return {
  "williamboman/mason-lspconfig.nvim",
  event = "LspAttach",
  lazy = true,
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "eslint",
      "ts_ls",
      "pyright",
      "rust_analyzer",
      "clangd",
      "gopls", -- Add gopls here
    },
    automatic_installation = true,
  },
}