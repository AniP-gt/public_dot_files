return {
  -- Diagnostic configuration
  -- This is not a plugin itself, but a configuration for Neovim's built-in diagnostics.
  -- Wrapped in a lazy.nvim spec to ensure it's loaded appropriately.
  "folke/lazy.nvim", -- Dummy plugin to attach the config
  config = function()
    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        source = "if_many",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Define diagnostic signs
    local signs = {
      Error = "✘",
      Warn = "▲",
      Hint = "⚑",
      Info = "»",
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end,
}
