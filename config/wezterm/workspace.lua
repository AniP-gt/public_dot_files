local wezterm = require("wezterm")
local workspaces = require("const.workspaces")

local M = {}

	function M.setup(config)
		local predefined_colors = {
			[workspaces.NAME_1] = "#f1d560",
			[workspaces.NAME_2] = "#60d5f1",
			[workspaces.NAME_3] = "#8cf160",
			[workspaces.NAME_4] = "#d160f1",
			[workspaces.NAME_5] = "#ff6b35",
			[workspaces.NAME_6] = "#ff1744",
			[workspaces.NAME_7] = "#00e5ff",
			[workspaces.NAME_8] = "#76ff03",
			[workspaces.NAME_9] = "#e91e63",
		}

		local function generate_workspace_color(workspace)
			if predefined_colors[workspace] then
				return predefined_colors[workspace]
			end

			local hash = 0
		local hash = 0
		for i = 1, #workspace do
			hash = (hash * 31 + string.byte(workspace, i)) % 360
		end
		local hue = hash / 60
		local x = 1 - math.abs(hue % 2 - 1)
		local r, g, b
		if hue < 1 then
			r, g, b = 1, x, 0
		elseif hue < 2 then
			r, g, b = x, 1, 0
		elseif hue < 3 then
			r, g, b = 0, 1, x
		elseif hue < 4 then
			r, g, b = 0, x, 1
		elseif hue < 5 then
			r, g, b = x, 0, 1
		else
			r, g, b = 1, 0, x
		end
		-- RGB値を16進数カラーコードに変換
		return string.format(
			"#%02x%02x%02x",
			math.floor(128 + r * 127),
			math.floor(128 + g * 127),
			math.floor(128 + b * 127)
		)
	end

	-- タブごとの色を生成する関数（最大9個まで）
	local function get_tab_color(tab_index)
		local tab_colors = {
			"#f1d560", -- 1: 黄色
			"#60d5f1", -- 2: 水色
			"#8cf160", -- 3: 緑色
			"#d160f1", -- 4: 紫色
			"#ff6b35", -- 5: オレンジ
			"#ff1744", -- 6: 赤色
			"#00e5ff", -- 7: シアン
			"#76ff03", -- 8: ライム
			"#e91e63", -- 9: ピンク
		}
		-- タブインデックスは0から始まるので+1して、9個でループ
		return tab_colors[(tab_index % 9) + 1]
	end

	-- タブバーの色を作成する関数
	local function create_tab_bar_colors(active_color)
		return {
			background = "#0a0a0a", -- タブバーの背景色
			active_tab = {
				bg_color = active_color, -- アクティブタブの背景色（ワークスペース色を使用）
				fg_color = "#0a0a0a", -- アクティブタブの文字色
				intensity = "Bold", -- 文字を太字に
			},
			inactive_tab = {
				bg_color = "#1f1f1f", -- 非アクティブタブの背景色
				fg_color = "#a0a0a0", -- 非アクティブタブの文字色
			},
			inactive_tab_hover = {
				bg_color = "#2f2f2f", -- ホバー時の背景色
				fg_color = "#c0c0c0", -- ホバー時の文字色
				italic = false,
			},
			new_tab = {
				bg_color = "#1a1a1a", -- 新規タブボタンの背景色
				fg_color = "#808080", -- 新規タブボタンの文字色
			},
			new_tab_hover = {
				bg_color = "#2a2a2a", -- 新規タブボタンホバー時の背景色
				fg_color = "#a0a0a0", -- 新規タブボタンホバー時の文字色
				italic = false,
			},
		}
	end

	-- タブタイトルのフォーマット設定
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = ""
		-- フォアグラウンドプロセスの名前を取得
		if tab.active_pane.foreground_process_name then
			title = tab.active_pane.foreground_process_name:match("([^/\\]+)$") or ""
		end

		-- プロセス名が空の場合、カレントディレクトリを使用
		if title == "" and tab.active_pane.current_working_dir then
			local cwd = tab.active_pane.current_working_dir
			if cwd then
				cwd = cwd:gsub("file://", ""):gsub("%%20", " ")
				title = cwd:match("([^/]+)/?$") or ""
				-- ホームディレクトリの場合は~に置換
				if cwd == wezterm.home_dir then
					title = "~"
				elseif cwd:find(wezterm.home_dir, 1, true) == 1 then
					title = "~" .. cwd:sub(#wezterm.home_dir + 1)
				end
			end
		end

		-- タイトルが空の場合のデフォルト値
		if title == "" then
			title = "shell"
		end

		-- タブ番号（1から開始）
		local tab_index = tab.tab_index + 1
		-- アクティブタブは太い区切り線、非アクティブは細い区切り線
		local separator = tab.is_active and "│" or "┊"

		-- タブごとの色を取得
		local tab_color = get_tab_color(tab.tab_index)
		local bg_color = tab.is_active and tab_color or "#1f1f1f"
		local fg_color = tab.is_active and "#0a0a0a" or "#a0a0a0"

		return {
			{ Background = { Color = bg_color } },
			{ Foreground = { Color = fg_color } },
			{ Text = "" .. separator .. " " .. tab_index .. ": " .. title .. " " },
		}
	end)

	-- ステータスバーの更新処理
	wezterm.on("update-status", function(window, pane)
		local workspace = window:active_workspace()
		local overrides = window:get_config_overrides() or {}
		local mux = wezterm.mux

		-- カラー設定を保持
		overrides.colors = config.colors

		-- 全ワークスペースを収集
		local workspace_tabs = {}
		local all_workspaces = {}
		for _, w in ipairs(mux.get_workspace_names()) do
			if w ~= "default" then
				table.insert(all_workspaces, w)
			end
		end

		-- ワークスペースタブの作成
		for _, ws_key in ipairs(all_workspaces) do
			local ws_name = ws_key
			local active_color = generate_workspace_color(ws_key)

			-- アクティブなワークスペースはハイライト表示
			if ws_key == workspace then
				table.insert(workspace_tabs, { Background = { Color = active_color } })
				table.insert(workspace_tabs, { Foreground = { Color = "#141414" } })
				table.insert(workspace_tabs, { Text = " " .. ws_name .. " " })
			else
				-- 非アクティブなワークスペースは暗い色で表示
				table.insert(workspace_tabs, { Background = { Color = "#2a2a2a" } })
				table.insert(workspace_tabs, { Foreground = { Color = "#808080" } })
				table.insert(workspace_tabs, { Text = " " .. ws_name .. " " })
			end

			-- ワークスペース間のスペース
			table.insert(workspace_tabs, { Background = { Color = "#1a1a1a" } })
			table.insert(workspace_tabs, { Text = "" })
		end

		-- 左側のステータスバーにワークスペースタブを表示
		window:set_left_status(wezterm.format(workspace_tabs))

		-- 右側のステータスバーにヘルプテキストを表示
		-- window:set_right_status(wezterm.format({
		-- 	{ Background = { Color = "#1a1a1a" } },
		-- 	{ Foreground = { Color = "#606060" } },
		-- 	{ Text = " Switch workspace: Cmd+S " },
		-- }))

		-- アクティブなワークスペースの色でタブバーをカスタマイズ
		local active_color = generate_workspace_color(workspace)
		overrides.colors.tab_bar = create_tab_bar_colors(active_color)

		-- 設定を適用
		window:set_config_overrides(overrides)
	end)
end

return M
