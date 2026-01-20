return {
  "vim-ruby/vim-ruby",
  ft = { "ruby", "eruby" },
  config = function()
    -- ERBタグのハイライト設定
    vim.g.ruby_indent_access_modifier_style = 'normal'
    vim.g.ruby_indent_assignment_style = 'variable'
    vim.g.ruby_indent_block_style = 'do'
  end,
}
