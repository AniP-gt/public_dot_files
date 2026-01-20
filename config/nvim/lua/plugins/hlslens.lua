return {
  "kevinhwang91/nvim-hlslens",
  config = function()
    require("hlslens").setup()
  end,
  keys = {
    { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Next search result" },
    { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], desc = "Previous search result" },
    { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor" },
    { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word under cursor backwards" },
  },
}
