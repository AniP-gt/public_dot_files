# Neovim Configuration

このリポジトリは、lazy.nvimを使った個人用のNeovim設定一式です。Luaで細かく分割されたモジュールと、`lazy-lock.json`によるプラグインバージョン固定で再現性を担保しています。

## ファイル構成

```
.
├── init.lua             # エントリーポイント。lazy.nvimのセットアップとcore/customの読込
├── lazy-lock.json       # プラグインのバージョン固定。:Lazy syncで更新
├── lua/
│   ├── core/            # options/keymaps/autocmdsなどの共通設定
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── autocmds.lua
│   ├── plugins/         # プラグインごとのspec群（lazy.nvimが自動探索）
│   └── custom/          # lazysql・posting・clipboard-fix・safe-yank等の独自ユーティリティ
└── README.md
```

## セットアップ手順

### 1. 必要な依存関係をインストール

```bash
# Node.js (Copilot用)
nodenv install 22.14.0
nodenv global 22.14.0

# ripgrep (Telescope用)
brew install ripgrep

# その他の依存関係
brew install lazygit
brew install neovim-remote

# Markdownプレビュー (markdown-preview.nvim)
# 自動でpre-builtバイナリをダウンロードするため、手動インストール不要
# 初回使用時に自動でダウンロードされます
```

### 2. Neovimを起動してプラグインをインストール

```bash
nvim
```

初回起動時にlazy.nvimが自動でインストールされ、`lua/plugins`配下のspecを読み込んでプラグインを展開します。

### 3. LSPサーバーのインストール（Mason経由）

Neovim内で以下を実行：

```vim
:Mason
```

必要なLSPサーバー（typescript-language-server, lua_ls, ruby_lspなど）を選択してインストールしてください。`lua/plugins/mason-tool-installer.lua`で定義されたツールは自動インストール対象になります。

## 設定概要

- **plugin manager**: `lazy.nvim`。`init.lua:33-65`ですべてのspecを`lua/plugins`からロードし、`lazy-lock.json`でバージョンを固定。
- **core modules**: エディタの基本設定は`lua/core/options.lua`、キーバインドは`lua/core/keymaps.lua`、自動コマンドは`lua/core/autocmds.lua`で管理。
- **custom utilities**: `lua/custom/*.lua`はVeryLazyイベント後に読み込まれ、tmux間の共有クリップボードやSQLラッパーなど独自機能を提供。
- **disabled defaults**: LazyVim標準のDashboard/Noiceなどは`lua/plugins/disable-*.lua`でオフにしているため、READMEのリストが正です。

## カスタムユーティリティ

| ファイル                       | 概要                                                                   |
| ------------------------------ | ---------------------------------------------------------------------- |
| `lua/custom/lazysql.lua`       | `:LazySQL`でローカルDBクライアントを開き、プロジェクト固有の接続を管理 |
| `lua/custom/posting.lua`       | ブログやメモの投稿補助コマンドを提供。浮動端末で外部CLIを起動          |
| `lua/custom/clipboard-fix.lua` | macOS + tmux環境でのクリップボード同期を改善                           |
| `lua/custom/safe-yank.lua`     | tmuxとの連携時にも安全にヤンクするためのヘルパー                       |

必要に応じて上記ファイルを編集し、独自のワークフローに合わせてください。

## プラグイン一覧

`lazy-lock.json`に記載されている全プラグインをアルファベット順で掲載しています。バージョン固定を更新する際は `:Lazy sync` 後に `lazy-lock.json` をコミットしてください。

| Plugin                                                                                    | 説明                                   |
| ----------------------------------------------------------------------------------------- | -------------------------------------- |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim)                                  | トグル式の行/ブロックコメント          |
| [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim)                     | CopilotとのチャットUI                  |
| [LazyVim](https://github.com/LazyVim/LazyVim)                                             | LazyVimのデフォルト設定を一部利用      |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                            | スニペットエンジン                     |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)                             | バッファタブ表示                       |
| [close-buffers.nvim](https://github.com/kazhala/close-buffers.nvim)                       | バッファ一括クローズ                   |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                                       | nvim-cmpのバッファソース               |
| [cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)                                     | コマンドライン補完                     |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                                   | LSP補完ソース                          |
| [cmp-path](https://github.com/hrsh7th/cmp-path)                                           | パス補完                               |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)                                | LuaSnip連携ソース                      |
| [conform.nvim](https://github.com/stevearc/conform.nvim)                                  | フォーマッタ実行管理                   |
| [copilot-cmp](https://github.com/zbirenbaum/copilot-cmp)                                  | Copilotをnvim-cmpに統合                |
| [copilot.lua](https://github.com/zbirenbaum/copilot.lua)                                  | GitHub Copilot本体プラグイン           |
| [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)                               | スタートアップ画面（現在は無効化中）   |
| [diagram.nvim](https://github.com/3rd/diagram.nvim)                                       | Mermaid/PlantUML表示                   |
| [dial.nvim](https://github.com/monaqa/dial.nvim)                                          | 数値や列挙値の増減操作                 |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim)                                | Git差分ビューア                        |
| [flash.nvim](https://github.com/folke/flash.nvim)                                         | 拡張ジャンプ/検索                      |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)                      | 共有スニペット集                       |
| [git-blame.nvim](https://github.com/f-person/git-blame.nvim)                              | 行単位のgit blame表示                  |
| [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)                       | メインカラースキーム                   |
| [gitlinker.nvim](https://github.com/linrongbin16/gitlinker.nvim)                          | GitHub/GitLab等へのパーマリンク生成    |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)                               | Git差分サインと操作                    |
| [hlchunk.nvim](https://github.com/shellRaining/hlchunk.nvim)                              | ブロック・インデントハイライト         |
| [image.nvim](https://github.com/3rd/image.nvim)                                           | Neovim内での画像レンダリング           |
| [lazy.nvim](https://github.com/folke/lazy.nvim)                                           | プラグインマネージャー                 |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)                                  | Lazygit連携                            |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)                              | ステータスライン                       |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)                  | ブラウザでのMarkdownプレビュー         |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)              | Masonとlspconfigのブリッジ             |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | フォーマッタ/リンタの自動インストール  |
| [mason.nvim](https://github.com/williamboman/mason.nvim)                                  | LSP/ツール管理UI                       |
| [mermaid.vim](https://github.com/mracos/mermaid.vim)                                      | Mermaid記法のシンタックス              |
| [mini.icons](https://github.com/echasnovski/mini.icons)                                   | Markdownレンダリング用のアイコンセット |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                                | 自動で括弧を閉じる                     |
| [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)                                      | Quickfixリスト強化                     |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                           | 補完エンジン本体                       |
| [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)                              | 検索ハイライトを拡張                   |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)                                    | 非同期リンタ実行                       |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                                | LSPクライアント設定                    |
| [nvim-obsidian-tasks](https://github.com/AniP-gt/nvim-obsidian-tasks.nvim)                | Obsidianタスク管理                     |
| [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar)                            | スクロールバー表示                     |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)                               | ファイルエクスプローラー               |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                     | Treesitter本体                         |
| [nvim-treesitter-endwise](https://github.com/RRethy/nvim-treesitter-endwise)              | `end`自動挿入                          |
| [nvim-treesitter-textsubjects](https://github.com/RRethy/nvim-treesitter-textsubjects)    | 文脈ベースのテキストオブジェクト       |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)                       | アイコン表示                           |
| [obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)                                 | Obsidianノート連携                     |
| [opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)                             | OpenCode CLI補助                       |
| [overseer.nvim](https://github.com/stevearc/overseer.nvim)                                | タスクランナーUI                       |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)                                  | Telescope等の依存ユーティリティ        |
| [project.nvim](https://github.com/ahmedkhalf/project.nvim)                                | プロジェクトルート自動検出             |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim)             | 括弧のレインボーハイライト             |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)      | Markdownのリアルタイム装飾             |
| [snacks.nvim](https://github.com/folke/snacks.nvim)                                       | UI/通知などのユーティリティ集          |
| [tagalong.vim](https://github.com/AndrewRadev/tagalong.vim)                               | HTMLタグ両端の同時編集                 |
| [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)  | Telescopeの高速ソーター                |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)                        | ファジーファインダ本体                 |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                         | TODO/FIXMEハイライト & リスト          |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)                             | 浮動/スプリットターミナル              |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)                               | 予備カラースキーム（現在は無効）       |
| [treesj](https://github.com/Wansmer/treesj)                                               | 構文木に基づいた分割/結合              |
| [trouble.nvim](https://github.com/folke/trouble.nvim)                                     | 診断・ロケーションリストUI             |
| [vim-rails](https://github.com/tpope/vim-rails)                                           | Rails向けヘルパー                      |
| [vim-ruby](https://github.com/vim-ruby/vim-ruby)                                          | Rubyシンタックス/ftplugin              |
| [vim-startuptime](https://github.com/dstein64/vim-startuptime)                            | 起動時間計測                           |
| [vim-test](https://github.com/vim-test/vim-test)                                          | テストランナー統合                     |
| [which-key.nvim](https://github.com/folke/which-key.nvim)                                 | キーマップヘルプポップアップ           |
| [winresizer](https://github.com/simeji/winresizer)                                        | ウィンドウリサイズ補助                 |

> `catppuccin/nvim` や `alpha-nvim` などのテーマ/画面はspecが存在するものの `enabled = false` のままなので、利用する場合は対応する `lua/plugins/*.lua` で有効化してください。

## カラースキームの変更

現在は`lua/plugins/github-nvim-theme.lua`でGitHub Dark系テーマを有効化しています。別テーマに切り替える場合は以下のファイルを調整してください。

- `lua/plugins/github-nvim-theme.lua` : GitHubテーマのスタイル/オプション
- `lua/plugins/tokyonight.lua` : `enabled = true`にするとTokyonightを読み込めます
- `lua/plugins/catppuccin.lua` : デフォルトでは無効。必要なら`enabled = true`に変更

`init.lua`ではフォールバックとして`vim.cmd.colorscheme`を呼び出すだけなので、実際の配色は各テーマspecで制御します。

## キーバインドの確認

主要なキーマップは `lua/core/keymaps.lua` にまとまっています。`<Space>` をリーダーキーに設定し、以下のようなショートカットを提供しています。

- `<C-e>`: nvim-treeを開閉
- `<C-p>`: Telescope Files検索
- `<Space>gg`: Lazygit起動（`lua/plugins/lazygit.lua`）
- `<Space>tt`: ToggleTermトグル
- `<Space>rr`: Overseerからタスク実行
- `<Space>mp`: Markdownプレビュートグル（`lua/plugins/markdown-preview.lua`）

追加変更は `keymaps.lua` で行うのが安全です。

## トラブルシューティング

### プラグインが正しくインストールされない場合

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
nvim --headless "+Lazy! sync" +qa
```

### LSPが動作しない場合

1. `:LspInfo`で状態を確認
2. `:Mason`で必要なLSPサーバーがインストールされているか確認
3. 言語固有の依存関係（TypeScriptの`node_modules`など）を確認

### Markdownプレビューが動作しない場合

1. `:MarkdownPreviewToggle` でプレビューを開く
2. エラーが出る場合、`:Lazy build markdown-preview.nvim` でpre-builtバイナリを再ダウンロード
3. ブラウザが開かない場合、`vim.g.mkdp_browser = 'chrome'` などでブラウザを指定
4. 更新エラーが出る場合、Lazy UIでプラグインを削除（`x`）して再インストール（`I`）

### lazy-lock.jsonの更新

新規プラグインを追加・削除した場合は `:Lazy sync` を実行し、生成された `lazy-lock.json` をコミットして他環境でも同じバージョンが入るようにしてください。
