return {
  "tpope/vim-rails",
  ft = { "ruby", "eruby", "haml", "slim" },
  config = function()
    -- ERBファイルでのRailsヘルパーの認識
    vim.g.rails_projections = {
      ["app/views/*.html.erb"] = {
        command = "view",
        template = {
          "<%%= %>"
        },
      },
    }
  end,
}
