#!/usr/bin/env zsh

# Zsh履歴管理の設定

# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=10000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# すでに存在するヒストリファイルにヒストリを追記
setopt append_history

# ヒストリファイルを複数のzshで共有
setopt share_history

# 重複を記録しない
setopt hist_ignore_all_dups

# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 特定のコマンドを履歴に保存しない
zshaddhistory() {
  local line="${1%%$'\n'}"
  local cmd="${line%% *}"

  # git cherry-pick と gch コマンドは記録しない
  [[ "$cmd" == "git" && "$line" =~ "cherry-pick" ]] && return 1
  [[ "$cmd" == "gch" ]] && return 1

  # 行が長すぎる場合は記録しない (500文字以上)
  [[ ${#line} -ge 500 ]] && return 1

  return 0
}