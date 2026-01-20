-- ERB専用のサポートプラグイン
return {
  -- vim-rails (ERBのより良いサポート)
  {
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
  },

  -- vim-ruby (Ruby/ERBの構文サポート強化)
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby", "eruby" },
    config = function()
      -- ERBタグのハイライト設定
      vim.g.ruby_indent_access_modifier_style = 'normal'
      vim.g.ruby_indent_assignment_style = 'variable'
      vim.g.ruby_indent_block_style = 'do'
    end,
  },

  -- Rainbow delimiters for ERB (using modern plugin)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = vim.tbl_extend("force", vim.g.rainbow_delimiters or {}, {
        strategy = {
          eruby = rainbow_delimiters.strategy.global,
          html = rainbow_delimiters.strategy.global,
        },
        query = {
          eruby = "rainbow-delimiters",
          html = "rainbow-delimiters",
        },
      })
    end,
  },
}