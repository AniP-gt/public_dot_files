return {
  -- Web devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },
}
