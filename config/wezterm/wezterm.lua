local font = require("font")
local appearance = require("appearance")
local keybindings = require("keybindings")
local workspaces = require("const.workspaces")
local tabline = require("plugins.tabline")
local cc_glow = require("plugins.cc-glow")

local config = {}

font.setup(config)
appearance.setup(config)
keybindings.setup(config)

cc_glow.setup(config)

tabline.setup(config)

config.default_workspace = workspaces.NAME_1

-- Unix Domainサーバーの定義（こうすることでtmux風にサーバーセッションとして管理できる）
-- config.unix_domains = {
--   {
--     name = "local_mux",
--   },
-- }

-- 起動時に特定のドメインに接続する
-- config.default_gui_startup_args = { "connect", "local_mux" }

return config
