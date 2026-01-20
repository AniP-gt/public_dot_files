return {
  "shellRaining/hlchunk.nvim",
  event = "VeryLazy",
  config = function()
    require("hlchunk").setup({
      chunk = {
        enable = true,
        use_treesitter = true,
        style = {
          "#806d9c",
        },
        duration = 200,
        delay = 100,
      },
      indent = {
        enable = true,
        chars = { "│" },
        style = {
          "#808080",
        },
      },
      line_num = {
        enable = true,
        style = "#806d9c",
      },
      blank = {
        enable = false,
      },
    })
  end,
}
