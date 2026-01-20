return {
  "mfussenegger/nvim-lint",
  dependencies = { "williamboman/mason.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      -- ESLint LSPがTypeScript/JavaScriptを処理するため、ここからは除外
      python = { "pylint", "cspell" },
      lua = { "luacheck", "cspell" },
      sh = { "shellcheck", "cspell" },
      -- cspell for all text files
      markdown = { "cspell" },
      text = { "cspell" },
      gitcommit = { "cspell" },
      -- Add cspell to common programming languages
      javascript = { "cspell" },
      typescript = { "cspell" },
      javascriptreact = { "cspell" },
      typescriptreact = { "cspell" },
      json = { "cspell" },
      yaml = { "cspell" },
      html = { "cspell" },
      css = { "cspell" },
    }

    -- Configure cspell to use our config file (with Japanese filtering)
    lint.linters.cspell = {
      cmd = "cspell",
      args = {
        "--no-progress",
        "--no-summary",
        "--config",
        vim.fn.expand("~/.cspell.json"),
      },
      stdin = true,
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_pattern(
        "(.+):(%d+):(%d+)%s+%-?%s*(%w+)%s+%-?%s*(.*)%s+%-?%s*%((.-)%)",
        { "file", "lnum", "col", "severity", "message", "word" },
        nil,
        {
          severity = vim.diagnostic.severity.WARN,
        }
      ),
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    -- Reduced frequency for better performance
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
