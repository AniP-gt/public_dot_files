local wezterm = require("wezterm")

-- 画面をいっぱいにする
wezterm.on("gui-startup", function()
	local _, _, window = wezterm.mux.spawn_window({})
	window:gui_window():maximize()
end)

local M = {}

function M.setup(config)
	-- スクロールバックバッファの行数（履歴の保持行数）
	config.scrollback_lines = 100000

	-- IME（日本語入力）の有効化
	config.use_ime = true

	-- ウィンドウの透明度設定
	config.window_background_opacity = 0.7 -- 背景の透明度（0.0〜1.0）
	config.macos_window_background_blur = 10 -- macOSのブラーエフェクト強度
	config.text_background_opacity = 1.0 -- テキスト背景の透明度

	-- ウィンドウ装飾の設定（タイトルバーを非表示にしてリサイズのみ可能に）
	config.window_decorations = "RESIZE"

	-- ターミナルタイプの設定（256色対応）
	config.term = "xterm-256color"

	-- ベル音の無効化
	config.audible_bell = "Disabled"

	-- ビジュアルベル（画面フラッシュ）の設定
	config.visual_bell = {
		fade_in_function = "EaseIn", -- フェードインのアニメーション
		fade_in_duration_ms = 150, -- フェードインの時間（ミリ秒）
		fade_out_function = "EaseOut", -- フェードアウトのアニメーション
		fade_out_duration_ms = 150, -- フェードアウトの時間（ミリ秒）
	}

	-- タブバーの設定
	config.enable_tab_bar = true -- タブバーを表示
	config.tab_bar_at_bottom = true -- タブバーを下部に配置
	config.use_fancy_tab_bar = false -- シンプルなタブバーを使用
	config.tab_max_width = 25 -- タブの最大幅
	config.show_tab_index_in_tab_bar = false -- タブ番号を非表示
	config.show_new_tab_button_in_tab_bar = false -- 新規タブボタンを非表示

	-- 非アクティブなペインの見た目を調整（薄く表示）
	config.inactive_pane_hsb = {
		saturation = 0.7, -- 彩度を70%に下げる
		brightness = 0.3, -- 明度を30%に下げる
	}

	-- カラーテーマの設定
	config.colors = {
		-- 基本色
		foreground = "#f9f7ef", -- 文字色
		background = "#141414", -- 背景色

		-- カーソルの色
		cursor_bg = "#f1d560", -- カーソル背景色
		cursor_fg = "#444844", -- カーソル文字色
		cursor_border = "#f1d560", -- カーソル枠線色

		-- 選択範囲の色
		selection_fg = "#f9f7ef", -- 選択範囲の文字色
		selection_bg = "#196a89", -- 選択範囲の背景色

		-- UIパーツの色
		scrollbar_thumb = "#6c6d6b", -- スクロールバーの色
		split = "#6c6d6b", -- ペイン分割線の色

		-- ANSI標準色（0-7）
		ansi = {
			"#444844", -- 0 (black)   黒
			"#d95673", -- 1 (red)     赤
			"#8cc06d", -- 2 (green)   緑
			"#eebe36", -- 3 (yellow)  黄
			"#5caadb", -- 4 (blue)    青
			"#b594ce", -- 5 (magenta) マゼンタ
			"#44a9ba", -- 6 (cyan)    シアン
			"#fbfaf7", -- 7 (white)   白
		},
		-- ANSI高輝度色（8-15）
		brights = {
			"#6c6d6b", -- 8  (bright black)   明るい黒
			"#dba1b4", -- 9  (bright red)     明るい赤
			"#898e38", -- 10 (bright green)   明るい緑
			"#8a6b3c", -- 11 (bright yellow)  明るい黄
			"#8399c9", -- 12 (bright blue)    明るい青
			"#887a9e", -- 13 (bright magenta) 明るいマゼンタ
			"#87c6d3", -- 14 (bright cyan)    明るいシアン
			"#bfc1bb", -- 15 (bright white)   明るい白
		},
	}

	-- マウス操作のバインディング
	config.mouse_bindings = {
		{
			-- 右クリックでコピー
			event = { Up = { streak = 1, button = "Right" } },
			mods = "NONE",
			action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
		},
		{
			-- 中クリックでペースト
			event = { Up = { streak = 1, button = "Middle" } },
			mods = "NONE",
			action = wezterm.action.PasteFrom("Clipboard"),
		},
	}
end

return M
