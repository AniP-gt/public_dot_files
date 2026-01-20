return {
  "NickvanDyke/opencode.nvim",
  lazy = false,
  dependencies = {
    {
      "folke/snacks.nvim",
      lazy = false,
      priority = 1000,
      opts = { input = {}, picker = {}, terminal = {} },
    },
  },
  config = function()
    local default_opts = {
      provider = {
        enabled = "terminal",
        terminal = {
          split = "right",
        },
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = vim.tbl_deep_extend("force", default_opts, vim.g.opencode_opts or {})
    vim.o.autoread = true

    local opencode = require("opencode")
    local keymap = vim.keymap.set

    keymap({ "n", "x" }, "<leader>oca", function()
      opencode.ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    keymap({ "n", "x" }, "<leader>ocs", function()
      opencode.select()
    end, { desc = "Execute opencode action…" })

    keymap({ "n", "t" }, "<leader>oct", function()
      opencode.toggle()
    end, { desc = "Toggle opencode" })

    keymap({ "n", "x" }, "go", function()
      return opencode.operator("@this ")
    end, { expr = true, desc = "Add range to opencode" })

    keymap("n", "goo", function()
      return opencode.operator("@this ") .. "_"
    end, { expr = true, desc = "Add line to opencode" })

    keymap("n", "<S-C-u>", function()
      opencode.command("session.half.page.up")
    end, { desc = "opencode half page up" })

    keymap("n", "<S-C-d>", function()
      opencode.command("session.half.page.down")
    end, { desc = "opencode half page down" })
  end,
}

