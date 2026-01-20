return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    lazy = false,
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "ruby",
          "html",
          "vue",
          "embedded_template",
          "css",
          "javascript",
          "typescript",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "tsx",
          "query",
          "python",
        },
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
      })

      vim.filetype.add({
        extension = {
          erb = "eruby",
        },
      })
    end,
  },
}
