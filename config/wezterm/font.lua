local wezterm = require("wezterm")

local M = {}

function M.setup(config)
	-- メインフォントの設定
	-- MesloLGS NFをボールドで使用（Powerlineやアイコンフォントに対応）
	config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })

	-- フォントサイズの設定
	config.font_size = 15

	-- フォントルール：条件に応じたフォントの切り替え設定
	config.font_rules = {
		{
			-- 通常のテキスト表示時の設定
			intensity = "Normal",
			italic = false,
			font = wezterm.font_with_fallback({
				"JetBrains Mono", -- プライマリフォント（Nerd Font対応）
				"JetBrains Mono Nerd Font", -- フォールバックフォント
			}, { weight = "Bold" }),
		},
	}
end

return M
