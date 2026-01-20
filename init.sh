#!/bin/sh
set -e

echo "Installing packages..."
brew install \
  git \                            # バージョン管理システム
  neovim \                         # モダンなVimエディタ
  tmux \                           # ターミナルマルチプレクサ
  docker \                         # コンテナ仮想化プラットフォーム
  fzf \                            # コマンドラインファジーファインダー
  zsh \                            # 高機能シェル
  lazygit \                        # Git操作のためのTUI
  lazysql \                        # SQL操作のためのTUI
  lazydocker \                     # Docker操作のためのTUI
  git-delta \                      # gitのdiff表示を改善
  powerlevel10k \                  # Zshテーマ
  ni \                             # インタラクティブなパイプラインビルダー
  tree \                           # ディレクトリ構造を木形式で表示
  ripgrep \                        # 高速なgrep代替ツール
  tree-sitter \                    # パーサージェネレータツール(ライブラリ)
  tree-sitter-cli \                # tree-sitter CLIツール(nvim-treesitter用)
  uv \                             # 高速なPythonパッケージマネージャ
  btop \                           # リソースモニタ
  ncdu \                           # ディスク使用量アナライザ
  google-japanese-ime \            # Google日本語入力
  jq \                             # JSONプロセッサ
  fd \                             # 高速なfind代替ツール
  eza \                            # モダンなls代替ツール
  terminal-notifier \              # macOS通知送信ツール
  gh \                             # GitHub CLI
  rmlint \                         # 重複ファイル検出ツール
  tlrc \                           # tldrクライアント(コマンド使用例表示)
  thefuck \                        # コマンド修正ツール
  bat \                            # cat代替ツール(シンタックスハイライト付き)
  zoxide \                         # スマートなcd代替ツール
  clipboard \                      # クリップボード操作ツール
  yazi \                           # ターミナルファイルマネージャー
  ffmpeg \                         # 動画・音声変換ツール
  sevenzip \                       # 圧縮・解凍ツール
  poppler \                        # PDFレンダリングライブラリ
  resvg \                          # SVGレンダリングツール
  imagemagick \                    # 画像処理ツール
  font-symbols-only-nerd-font \    # Nerd Font(アイコンフォント)
  font-jetbrains-mono-nerd-font \  # Nerd Font(アイコンフォント)
  timidity \                       # MIDIプレイヤー
  mermaid-cli \                    # Mermaid図描画ツール
  tabiew \                         # CSV/TSVビューア・変換ツール
  libiconv \                       # 文字コード変換ライブラリ
  rsync \                          # ファイル同期・転送ツール
  opencode \ 
  ghq \                            # リポジトリ管理ツール
  go \                             # Go言語環境
  tmuxinator                       # tmuxセッション管理ツール

# volta
curl https://get.volta.sh | bash

# gwq (git worktree管理ツール)
go install github.com/d-kuro/gwq/cmd/gwq@latest

TPM_DIR="$HOME/.tmux/plugins/tpm"

# TPM がなければインストール
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# プラグインをインストール
"$TPM_DIR/bin/install_plugins"

# tmux plguin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

TPM_DIR="$HOME/.tmux/plugins/tpm"

# TPM がなければインストール
if [ ! -d "$TPM_DIR" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

# プラグインをインストール
"$TPM_DIR/bin/install_plugins"

