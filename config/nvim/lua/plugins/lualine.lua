return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    })
  end,
}
