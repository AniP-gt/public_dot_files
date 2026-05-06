local wezterm = require("wezterm")

local M = {}
local ai_ring_module

function M.setup(config)
	if not ai_ring_module then
		ai_ring_module = wezterm.plugin.require("https://github.com/AniP-gt/cc-glow.wezterm")
	end

	ai_ring_module.apply_to_config(config, {
		indicator = "●",
		color_done = "#A6E22E",
		color_running = "#66D9EF",
		position = "left",
	})
end

function M.agent_status_component(tab)
	if not ai_ring_module then
		return ""
	end

	local status = ai_ring_module.get_tab_status(tab.tab_id)
	if not status then
		return ""
	end

	return wezterm.format({
		{ Foreground = { Color = status.color } },
		{ Text = status.icon },
	})
end

function M.get_workspace_indicator(workspace_name)
	if not ai_ring_module then
		return ""
	end

	local status = ai_ring_module.get_workspace_status(workspace_name)
	if not status then
		return ""
	end

	return wezterm.format({
		{ Foreground = { Color = status.color } },
		{ Text = status.icon },
	})
end

M.ai_ring = ai_ring_module

return M
