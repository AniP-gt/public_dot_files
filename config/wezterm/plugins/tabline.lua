local wezterm = require("wezterm")
local ai_ring = require("plugins.cc-glow")

local M = {}
local tabline_module

-- ワークスペース内にリモート接続中のpaneがあるか判定
local function workspace_has_remote(workspace_name)
  for _, mux_win in ipairs(wezterm.mux.all_windows()) do
    if mux_win:get_workspace() == workspace_name then
      for _, tab in ipairs(mux_win:tabs()) do
        for _, pane_info in ipairs(tab:panes_with_info()) do
          if pane_info.pane then
            local uv = pane_info.pane:get_user_vars()
            if uv and (uv.WEZTERM_REMOTE == "true" or uv.WEZTERM_REMOTE == "1") then
              return true
            end
          end
        end
      end
    end
  end
  return false
end

-- 全ワークスペース名を表示するカスタムコンポーネント
-- FormatItem配列を返す（util.luaが直接挿入する）
-- アクティブ: 黄色文字（リモートでも黄色優先）
-- 非アクティブ+リモート: 赤色文字
-- 非アクティブ+通常: 白文字
local function all_workspaces(window)
  local active = window:active_workspace()
  local names = wezterm.mux.get_workspace_names()

  local parts = {}
  for _, name in ipairs(names) do
    if name ~= "default" then
      local indicator = ai_ring.get_workspace_indicator(name)
      local is_remote = workspace_has_remote(name)

      local fg, bold
      if name == active then
        fg = "#e5c07b"
        bold = true
      elseif is_remote then
        fg = "#cc3333"
        bold = true
      else
        fg = "#ffffff"
        bold = false
      end

      -- 各ワークスペースを個別にwezterm.formatで文字列化
      local fmt_items = {}
      if indicator ~= "" then
        table.insert(fmt_items, { Text = indicator .. " " })
      end
      table.insert(fmt_items, { Foreground = { Color = fg } })
      table.insert(fmt_items, { Attribute = { Intensity = bold and "Bold" or "Normal" } })
      table.insert(fmt_items, { Text = name })
      table.insert(parts, wezterm.format(fmt_items))
    end
  end
  return table.concat(parts, " | ")
end

function M.setup(config)
  if not tabline_module then
    -- tabline_module = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
    tabline_module = wezterm.plugin.require("https://github.com/AniP-gt/tabline.wez")
  end

  tabline_module.setup({
    options = {
      icons_enabled = true,
      theme = "Gruvbox Material (Gogh)",
      tabs_enabled = true,
      theme_overrides = {},
      section_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thick,
        right = wezterm.nerdfonts.ple_left_half_circle_thick,
      },
      component_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thin,
        right = wezterm.nerdfonts.ple_left_half_circle_thin,
      },
      tab_separators = {
        left = wezterm.nerdfonts.ple_right_half_circle_thick,
        right = wezterm.nerdfonts.ple_left_half_circle_thick,
      },
    },
    sections = {
      tabline_a = { "mode" },
      tabline_b = { all_workspaces },
      tabline_c = { " " },
      tab_active = {
        ai_ring.agent_status_component,
        "index",
        { "process", padding = { left = 0, right = 1 } },
      },
      tab_inactive = {
        ai_ring.agent_status_component,
        "index",
        { "cwd",    padding = { left = 0, right = 1 } },
        { "zoomed", padding = 0 },
      },
      tabline_x = {},
      tabline_y = { "datetime", style = "%H:%M", "battery" },
      tabline_z = { "domain" },
    },
    extensions = {},
  })

  tabline_module.apply_to_config(config)
end

M.tabline = tabline_module

return M
