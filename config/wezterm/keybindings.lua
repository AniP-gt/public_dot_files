local wezterm = require("wezterm")
local act = wezterm.action
local workspaces = require("const.workspaces")

local M = {}

function M.setup(config)
	-- tmux風のプレフィックスキー設定 (Ctrl+q)
	config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 }

	config.keys = config.keys or {}

	-- macOSでOption+¥をバックスラッシュとして扱う
	config.send_composed_key_when_left_alt_is_pressed = false
	config.send_composed_key_when_right_alt_is_pressed = false

	local keys = {
		-- Option + ¥ でバックスラッシュを入力
		{ key = "¥", mods = "ALT", action = act.SendString("\\") },
		-- tmux風: Ctrl+q をプレフィックスとしたワークスペース操作
		-- 新規ワークスペースの作成 (tmuxのnew-sessionに相当)
		{
			key = ":",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter name for new workspace:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
					end
				end),
			}),
		},

		-- ワークスペースの選択 (tmuxのchoose-sessionに相当)
		{ key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

		-- ペイン間の移動 (tmux風: prefix + hjkl)
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

		-- ペインのリサイズ (tmux風: prefix + HJKL)
		{ key = "H", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
		{ key = "J", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "K", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "L", mods = "LEADER|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

		-- 既存のワークスペース切り替え (CMD+数字は維持)
		{ key = "1", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_1 }) },
		{ key = "2", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_2 }) },
		{ key = "3", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_3 }) },
		{ key = "4", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_4 }) },
		{ key = "5", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_5 }) },
		{ key = "6", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_6 }) },
		{ key = "7", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_7 }) },
		{ key = "8", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_8 }) },
		{ key = "9", mods = "CMD", action = act.SwitchToWorkspace({ name = workspaces.NAME_9 }) },

		-- タブの操作
		{ key = "t", mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = false }) },

		-- コピーモード
		{ key = "v", mods = "CMD|SHIFT", action = wezterm.action.ActivateCopyMode },
		{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

		-- コピー＆ペースト
		{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },

		-- 検索
		{ key = "f", mods = "CMD", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
		{ key = "f", mods = "CMD|SHIFT", action = wezterm.action.Search({ Regex = "" }) },

		-- ペイン分割
		{ key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- 矢印キーでのペイン移動も維持 (オプション)
		{ key = "[", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Prev") },
		{ key = "]", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Next") },

		-- ペインを閉じる
		{ key = "w", mods = "CMD|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

		-- 手動でワークスペースをセットアップ
		{
			key = "S",
			mods = "LEADER|SHIFT",
			action = wezterm.action_callback(function(window, pane)
				local startup = require("startup")
				startup.manual_setup_workspaces()
				window:toast_notification("wezterm", "Workspaces setup completed", nil, 2000)
			end),
		},
	}

	-- Ctrl + 1..9 でタブ切替（ActivateTab は 0 ベース）
	for i = 1, 9 do
		table.insert(keys, {
			key = tostring(i),
			mods = "CTRL",
			action = act.ActivateTab(i - 1),
		})
	end

	-- Ctrl + 0 を右端のタブに割り当て（任意）
	table.insert(keys, {
		key = "0",
		mods = "CTRL",
		action = act.ActivateTab(-1), -- -1 = right-most tab
	})

	for _, key in ipairs(keys) do
		table.insert(config.keys, key)
	end

	config.key_tables = {
		copy_mode = {
			-- vim風の移動
			{ key = "h", action = wezterm.action.CopyMode("MoveLeft") },
			{ key = "j", action = wezterm.action.CopyMode("MoveDown") },
			{ key = "k", action = wezterm.action.CopyMode("MoveUp") },
			{ key = "l", action = wezterm.action.CopyMode("MoveRight") },

			-- 単語単位の移動
			{ key = "w", action = wezterm.action.CopyMode("MoveForwardWord") },
			{ key = "b", action = wezterm.action.CopyMode("MoveBackwardWord") },
			{ key = "e", action = wezterm.action.CopyMode("MoveForwardWordEnd") },

			-- 行の先頭・末尾
			{ key = "0", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },
			{ key = "$", action = wezterm.action.CopyMode("MoveToEndOfLineContent") },
			{ key = "^", action = wezterm.action.CopyMode("MoveToStartOfLineContent") },

			-- ページ移動
			{ key = "PageUp", action = wezterm.action.CopyMode("PageUp") },
			{ key = "PageDown", action = wezterm.action.CopyMode("PageDown") },
			{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode("PageUp") },
			{ key = "d", mods = "CTRL", action = wezterm.action.CopyMode("PageDown") },

			-- ドキュメントの先頭・末尾
			{ key = "g", action = wezterm.action.CopyMode("MoveToScrollbackTop") },
			{ key = "G", action = wezterm.action.CopyMode("MoveToScrollbackBottom") },

			-- 選択開始
			{ key = "v", action = wezterm.action.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "V", action = wezterm.action.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "v", mods = "CTRL", action = wezterm.action.CopyMode({ SetSelectionMode = "Block" }) },

			-- 選択モードの切り替え
			{ key = "o", action = wezterm.action.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "O", action = wezterm.action.CopyMode("MoveToSelectionOtherEndHoriz") },

			-- コピー＆終了
			{
				key = "y",
				action = wezterm.action.Multiple({
					wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
					wezterm.action.CopyMode("Close"),
				}),
			},
			{
				key = "Enter",
				action = wezterm.action.Multiple({
					wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
					wezterm.action.CopyMode("Close"),
				}),
			},

			-- キャンセル
			{ key = "q", action = wezterm.action.CopyMode("Close") },
			{ key = "Escape", action = wezterm.action.CopyMode("Close") },

			-- 検索
			{ key = "/", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
			{ key = "?", action = wezterm.action.Search({ CaseSensitiveString = "" }) },
			{ key = "n", action = wezterm.action.CopyMode("NextMatch") },
			{ key = "N", action = wezterm.action.CopyMode("PriorMatch") },
		},

		search_mode = {
			{ key = "Enter", action = wezterm.action.CopyMode("PriorMatch") },
			{ key = "Escape", action = wezterm.action.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = wezterm.action.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = wezterm.action.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = wezterm.action.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = wezterm.action.CopyMode("ClearPattern") },
			{ key = "PageUp", action = wezterm.action.CopyMode("PriorMatchPage") },
			{ key = "PageDown", action = wezterm.action.CopyMode("NextMatchPage") },
			{ key = "UpArrow", action = wezterm.action.CopyMode("PriorMatch") },
			{ key = "DownArrow", action = wezterm.action.CopyMode("NextMatch") },
		},
	}
end

return M
