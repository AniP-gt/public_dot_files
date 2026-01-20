return {
  -- Scrollbar with diagnostics and Git integration
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("scrollbar").setup({
        show = true,
        show_in_active_only = false,
        hide_if_all_visible = false,
        throttle_ms = 100,
        excluded_filetypes = {
          "prompt",
          "TelescopePrompt",
          "noice",
          "NvimTree",
        },
        handlers = {
          cursor = true,
          diagnostic = true,
          gitsigns = true,
        },
      })
    end,
  },
}