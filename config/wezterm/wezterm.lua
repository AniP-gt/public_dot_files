local font = require("font")
local appearance = require("appearance")
local keybindings = require("keybindings")
local workspace = require("workspace")
local workspaces = require("const.workspaces")

local config = {}

font.setup(config)
appearance.setup(config)
keybindings.setup(config)
workspace.setup(config)

config.default_workspace = workspaces.NAME_1

return config
