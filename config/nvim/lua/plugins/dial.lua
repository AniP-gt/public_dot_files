local vim = vim

return {
  {
    "monaqa/dial.nvim",
    lazy = true,
    keys = {
      { "<C-a>", mode = { "n" }, desc = "Dial increment (normal)" },
      { "<C-x>", mode = { "n" }, desc = "Dial decrement (normal)" },
      { "g<C-a>", mode = { "n" }, desc = "Dial g-increment (normal)" },
      { "g<C-x>", mode = { "n" }, desc = "Dial g-decrement (normal)" },
      { "<C-a>", mode = { "x" }, desc = "Dial increment (visual)" },
      { "<C-x>", mode = { "x" }, desc = "Dial decrement (visual)" },
      { "g<C-a>", mode = { "x" }, desc = "Dial g-increment (visual)" },
      { "g<C-x>", mode = { "x" }, desc = "Dial g-decrement (visual)" },
    },
    config = function()
      local augend = require("dial.augend")
      local config = require("dial.config")
      local map = require("dial.map")

      config.augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.bool,
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
        },
      })

      local function bind(mode, lhs, operation, dial_mode, description)
        vim.keymap.set(mode, lhs, function()
          map.manipulate(operation, dial_mode)
        end, { desc = description, noremap = true, silent = true })
      end

      bind("n", "<C-a>", "increment", "normal", "Dial increment (normal)")
      bind("n", "<C-x>", "decrement", "normal", "Dial decrement (normal)")
      bind("n", "g<C-a>", "increment", "gnormal", "Dial g-increment (normal)")
      bind("n", "g<C-x>", "decrement", "gnormal", "Dial g-decrement (normal)")
      bind("x", "<C-a>", "increment", "visual", "Dial increment (visual)")
      bind("x", "<C-x>", "decrement", "visual", "Dial decrement (visual)")
      bind("x", "g<C-a>", "increment", "gvisual", "Dial g-increment (visual)")
      bind("x", "g<C-x>", "decrement", "gvisual", "Dial g-decrement (visual)")
    end,
  },
}
