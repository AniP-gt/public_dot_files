#!/usr/bin/env zsh

# 共通関数の定義

# iTerm2のTab Colorの設定
# 使い方: tab-color 255 255 200 # light yellow
# @see https://zenn.dev/anozon/articles/iterm2-tab-color
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

# Terminal Notifier wrapper function
# Usage: notify command [args...]
# Example: notify npm install
# Example: notify make build
# Example: notify sleep 5
notify() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: notify command [args...]"
        return 1
    fi

    # Run the command with all arguments
    # Enable alias expansion
    eval "$@"
    local exit_code=$?

    # Create message from command
    local cmd_string="$*"

    # Send notification based on exit code
    if [[ $exit_code -eq 0 ]]; then
        terminal-notifier -title "Command Complete" -subtitle "成功" -message "$cmd_string finished" -sound Glass
    else
        terminal-notifier -title "Command Failed" -subtitle "失敗 (Exit: $exit_code)" -message "$cmd_string failed" -sound Basso
    fi

    return $exit_code
}

# Brew maintenance on shell startup
# Runs brew update and cleanup in background if not run recently
brew_auto_update() {
    local last_update_file="$HOME/.brew_last_update"
    local current_time=$(date +%s)
    local update_interval=$((24 * 60 * 60))  # 24 hours in seconds

    # Check if we should update
    if [[ -f "$last_update_file" ]]; then
        local last_update=$(cat "$last_update_file")
        local time_diff=$((current_time - last_update))

        if [[ $time_diff -lt $update_interval ]]; then
            return 0
        fi
    fi

    # Run update and cleanup in background
    {
        /opt/homebrew/bin/brew update > /dev/null 2>&1
        /opt/homebrew/bin/brew cleanup > /dev/null 2>&1
        echo $current_time > "$last_update_file"
    } &!
}

# Run brew auto update on shell startup
brew_auto_update

# ChatGPT query function
# Usage: gpt [query text]
# If no arguments provided, enters multi-line input mode (Ctrl-D to finish)
# Example: gpt How do I use zsh functions?
# Example: gpt (then type multi-line query and press Ctrl-D)
gpt() {
    local query=""

    if [[ $# -gt 0 ]]; then
        # 引数が与えられた場合
        query="$*"
    else
        # 引数がない場合、複数行入力を受け付ける
        echo "Enter your query (press Ctrl-D to finish):"
        query=$(cat)
    fi

    # 空のクエリの場合は終了
    if [[ -z "$query" ]]; then
        echo "No query provided."
        return 1
    fi

    # URLエンコード
    local encoded=$(printf '%s' "$query" | uv run python -c "import sys, urllib.parse; data=sys.stdin.buffer.read().decode('utf-8', errors='replace'); print(urllib.parse.quote(data.strip(), safe=''))")

    # ブラウザで開く
    open "https://chat.openai.com/?q=$encoded"
}

# Perplexity AI query function
# Usage: pplx [query text]
# If no arguments provided, enters multi-line input mode (Ctrl-D to finish)
# Example: pplx What is the latest news on AI?
# Example: pplx (then type multi-line query and press Ctrl-D)
pplx() {
    local query=""

    if [[ $# -gt 0 ]]; then
        # 引数が与えられた場合
        query="$*"
    else
        # 引数がない場合、複数行入力を受け付ける
        echo "Enter your query (press Ctrl-D to finish):"
        query=$(cat)
    fi

    # 空のクエリの場合は終了
    if [[ -z "$query" ]]; then
        echo "No query provided."
        return 1
    fi

    # URLエンコード
    local encoded=$(printf '%s' "$query" | uv run python -c "import sys, urllib.parse; data=sys.stdin.buffer.read().decode('utf-8', errors='replace'); print(urllib.parse.quote(data.strip(), safe=''))")

    # ブラウザで開く
    open "https://www.perplexity.ai/search?q=$encoded"
}

# Google Gemini AI Search query function
# Usage: gai [query text]
# If no arguments provided, enters multi-line input mode (Ctrl-D to finish)
# Example: gai Explain quantum computing
# Example: gai (then type multi-line query and press Ctrl-D)
gai() {
    local query=""

    if [[ $# -gt 0 ]]; then
        # 引数が与えられた場合
        query="$*"
    else
        # 引数がない場合、複数行入力を受け付ける
        echo "Enter your query (press Ctrl-D to finish):"
        query=$(cat)
    fi

    # 空のクエリの場合は終了
    if [[ -z "$query" ]]; then
        echo "No query provided."
        return 1
    fi

    # URLエンコード
    local encoded=$(printf '%s' "$query" | uv run python -c "import sys, urllib.parse; data=sys.stdin.buffer.read().decode('utf-8', errors='replace'); print(urllib.parse.quote(data.strip(), safe=''))")

    # ブラウザで開く（Google AI Search Mode）
    open "https://www.google.com/search?udm=50&source=searchlabs&q=$encoded"
}

# ---------- obsidian-commi -------------
# Obsidian vault を日時付きバックアップメッセージでコミット
obs-commit() {
  local ts msg

  ts="$(date '+%Y-%m-%d %H:%M:%S')"
  msg="vault backup: ${ts}"

  if [[ ! -d ".git" ]]; then
    echo "Not a git repository."
    return 1
  fi

  # ワーキングツリーに未追跡ファイルを含めた差分があるか確認
  if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit."
    return 0
  fi

  # リポジトリルートを特定してそこで操作
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null || echo ".")
  current_branch=$(git -C "$repo_root" rev-parse --abbrev-ref HEAD)
  git -C "$repo_root" add --all
  git -C "$repo_root" commit -m "$msg"
  git -C "$repo_root" push origin "$current_branch"
}

# zsh_history を chezmoi 経由でバックアップ・コミット・プッシュ
zsh_history() {
  chezmoi add ~/.zsh_history
  cd ~/.local/share/chezmoi
  git add dot_zsh_history
  git commit -m "Update zsh history: $(date '+%Y-%m-%)d %H:%M:%S')"
  git push origin main
}
