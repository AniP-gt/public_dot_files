return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  lazy = true,
  opts = {
    padding = true,
    sticky = true,
    toggler = {
      line = "gcc",
      block = "gbc",
    },
    opleader = {
      line = "gc",
      block = "gb",
    },
  },
  config = function(_, opts)
    require("Comment").setup(opts)

    -- Set custom commentstring for JSON files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "json",
      callback = function()
        vim.bo.commentstring = "// %s"
      end,
    })
  end,
}
