#!/usr/bin/env zsh

# Git自動同期設定
# cdコマンドでディレクトリ移動時に自動的にGit操作を実行

# 自動pullを行うブランチのリスト
readonly AUTO_PULL_BRANCHES=(
    "main"
    "master"
    "rc/release"
)

# Gitリポジトリかどうかをチェック
_is_git_repo() {
    [[ -d ".git" ]] || git rev-parse --git-dir &>/dev/null
}

# 現在のブランチ名を取得
_get_current_branch() {
    git branch --show-current 2>/dev/null
}

# 指定されたブランチが自動pull対象かチェック
_should_auto_pull() {
    local branch=$1
    for target in "${AUTO_PULL_BRANCHES[@]}"; do
        [[ "$branch" == "$target" ]] && return 0
    done
    return 1
}

# メイン関数: cd時にGit操作を自動実行
cd_git_sync() {
    # zoxide (z) を使用してディレクトリ移動
    z "$@"
    local cd_result=$?

    # cdが失敗した場合は終了
    [[ $cd_result -ne 0 ]] && return $cd_result

    # Gitリポジトリでない場合は終了
    _is_git_repo || return $cd_result

    # fetchを実行
    echo "📦 Git repository detected. Fetching..."
    git fetch --quiet

    # 現在のブランチを取得
    local current_branch=$(_get_current_branch)

    # 自動pull対象のブランチの場合はpullを実行
    if _should_auto_pull "$current_branch"; then
        echo "🔄 Branch '$current_branch' - Pulling latest changes..."
        git pull --quiet
    fi

    return $cd_result
}

# cdコマンドのエイリアスを設定
alias cd='cd_git_sync'