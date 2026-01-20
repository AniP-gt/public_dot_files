return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  enabled = false, -- Temporarily disabled for performance
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "eslint_d",
        "eslint-lsp",
        "stylua",
        "luacheck",
        "typescript-language-server",
        "cspell",
        "cspell-lsp",
      },
      auto_update = false,
      run_on_start = true,
    })
  end,
}
