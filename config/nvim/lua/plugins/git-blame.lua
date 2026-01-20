return {
  "f-person/git-blame.nvim",
  event = "BufRead",
  config = function()
    vim.g.gitblame_enabled = 1
    vim.g.gitblame_message_template = "<author> • <date> • <summary>"
    vim.g.gitblame_date_format = "%Y-%m-%d"
  end,
}
