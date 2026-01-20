return {
  "dstein64/vim-startuptime",
  cmd = "StartupTime",
  keys = {
    { "<leader>ps", "<cmd>StartupTime<cr>", desc = "Startup time profiler" },
  },
  config = function()
    vim.g.startuptime_tries = 10
  end,
}
