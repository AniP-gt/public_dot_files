return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  event = "InsertEnter",
  lazy = true,
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    {
      "kmarius/jsregexp",
      build = "make install_jsregexp",
      optional = true,
    },
  },
  config = function()
    local luasnip = require("luasnip")

    luasnip.config.setup({
      enable_autosnippets = true,
    })

    require("luasnip.loaders.from_vscode").lazy_load()

    local s = luasnip.snippet
    local t = luasnip.text_node
    local i = luasnip.insert_node

    luasnip.add_snippets("javascript", {
      s("clg", {
        t("console.log("),
        i(1),
        t(");"),
      }),
      s("cle", {
        t("console.error("),
        i(1),
        t(");"),
      }),
      s("clw", {
        t("console.warn("),
        i(1),
        t(");"),
      }),
      s("clt", {
        t("console.table("),
        i(1),
        t(");"),
      }),
    })

    luasnip.add_snippets("typescript", {
      s("clg", {
        t("console.log("),
        i(1),
        t(");"),
      }),
      s("cle", {
        t("console.error("),
        i(1),
        t(");"),
      }),
      s("clw", {
        t("console.warn("),
        i(1),
        t(");"),
      }),
      s("clt", {
        t("console.table("),
        i(1),
        t(");"),
      }),
    })

    luasnip.add_snippets("javascriptreact", {
      s("clg", {
        t("console.log("),
        i(1),
        t(");"),
      }),
      s("cle", {
        t("console.error("),
        i(1),
        t(");"),
      }),
      s("clw", {
        t("console.warn("),
        i(1),
        t(");"),
      }),
      s("clt", {
        t("console.table("),
        i(1),
        t(");"),
      }),
    })

    luasnip.add_snippets("typescriptreact", {
      s("clg", {
        t("console.log("),
        i(1),
        t(");"),
      }),
      s("cle", {
        t("console.error("),
        i(1),
        t(");"),
      }),
      s("clw", {
        t("console.warn("),
        i(1),
        t(");"),
      }),
      s("clt", {
        t("console.table("),
        i(1),
        t(");"),
      }),
    })

    luasnip.add_snippets("lua", {
      s("pr", {
        t("print("),
        i(1),
        t(")"),
      }),
      s("req", {
        t("require('"),
        i(1),
        t("')"),
      }),
    })

    ---@diagnostic disable-next-line: undefined-global
    local keymap = vim.keymap

    keymap.set({ "i", "s" }, "<C-k>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true })

    keymap.set({ "i", "s" }, "<C-j>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { silent = true })

    keymap.set("i", "<C-l>", function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end)
  end,
}
