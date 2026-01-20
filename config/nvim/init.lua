-- Setup LuaRocks path for magick rock
local home = os.getenv("HOME")
package.path = package.path .. ";" .. home .. "/.luarocks/share/lua/5.1/?.lua"
package.path = package.path .. ";" .. home .. "/.luarocks/share/lua/5.1/?/init.lua"
package.cpath = package.cpath .. ";" .. home .. "/.luarocks/lib/lua/5.1/?.so"

if vim.loader then
  vim.loader.enable()
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 基本的なオプション設定のみ
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Load core configuration (追加テスト)
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Disable LazyVim import order check
vim.g.lazyvim_check_order = false

-- Setup lazy.nvim with plugins directory
require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
    version = false,
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
      path = vim.fn.stdpath("cache") .. "/lazy/cache",
    },
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Defer custom utilities to VeryLazy event for better startup performance
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    require("custom.lazysql")
    require("custom.posting")
    require("custom.clipboard-fix")
    require("custom.safe-yank")
  end,
})
