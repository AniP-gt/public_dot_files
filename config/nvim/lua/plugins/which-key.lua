return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  opts = {
    spec = {
      { "<leader>p", group = "profiling" },
      { "<leader>ps", desc = "Startup time" },
      { "<leader>pl", desc = "Lazy profiler" },
      { "<leader>pm", desc = "Lazy manager" },
      { "<leader>d", group = "docker" },
      { "<leader>dd", desc = "Docker (LazyDocker)" },
      { "<leader>ds", desc = "Docker split (LazyDocker)" },
      { "<leader>ld", desc = "Docker (LazyDocker)" },
    },
  },
}
