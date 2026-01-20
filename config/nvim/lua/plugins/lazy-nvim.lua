return {
  -- Diagnostic configuration
  {
    "folke/lazy.nvim",
    keys = {
      { "<leader>l", false },
    },
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
  },
}
