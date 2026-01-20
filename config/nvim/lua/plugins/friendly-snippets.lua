return {
  "rafamadriz/friendly-snippets",
  dependencies = { "L3MON4D3/LuaSnip" },
  config = function()
    local luasnip_ok, luasnip_loader = pcall(require, "luasnip.loaders.from_vscode")
    if luasnip_ok then
      luasnip_loader.lazy_load()
    end
  end,
}
