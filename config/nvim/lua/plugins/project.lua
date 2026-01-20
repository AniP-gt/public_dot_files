return {
  "ahmedkhalf/project.nvim",
  event = "VimEnter",
  lazy = true,
  config = function()
    -- Monkey patch the deprecated function to suppress warning
    vim.deprecate = function(name, alternative, version, extra) 
      if name == "vim.lsp.buf_get_clients" then return end
      -- Call original for other deprecations if needed
    end
    
    require("project_nvim").setup({
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    })
  end,
}
