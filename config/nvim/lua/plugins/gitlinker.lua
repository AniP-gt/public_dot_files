return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  keys = {
    {
      "<leader>gy",
      "<cmd>GitLink<cr>",
      desc = "Copy git link",
    },
    {
      "<leader>gy",
      "<cmd>GitLink<cr>",
      mode = "v",
      desc = "Copy git link",
    },
    {
      "<leader>gY",
      "<cmd>GitLink!<cr>",
      desc = "Open git link in browser",
    },
  },
  config = function()
    require("gitlinker").setup({
      router = {
        browse = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
        blame = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blame/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
      },
    })
  end,
}
