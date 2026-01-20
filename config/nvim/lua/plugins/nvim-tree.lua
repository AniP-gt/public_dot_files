return {
  "nvim-tree/nvim-tree.lua",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeResize" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
  },
  opts = {
    sort_by = "case_sensitive",
    view = {
      width = 40,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false, -- gitignoreされているファイルも表示
      custom = {}, -- カスタムフィルタをクリア
    },
    git = {
      enable = true,
      ignore = false, -- gitignoreを無視
    },
    update_focused_file = {
      enable = true,
      update_root = false,
      ignore_list = {},
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- nvim-treeのウィンドウ幅を調整するコマンド
    vim.api.nvim_create_user_command("NvimTreeResize", function(cmd_opts)
      local width = tonumber(cmd_opts.args)
      if width then
        require("nvim-tree.view").resize(width)
      else
        print("Usage: :NvimTreeResize <width>")
      end
    end, { nargs = 1 })
  end,
}
