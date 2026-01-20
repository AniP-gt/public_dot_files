# ---------- fzf設定 -------------
# 履歴検索
function fzf-history-selection() {
    BUFFER=$(history -n 1 | awk '!a[$0]++' | fzf --height 40% --reverse --no-sort +m --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^R' fzf-history-selection

# ディレクトリ移動（コマンド履歴）
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':completion:*' recent-dirs-insert both
  zstyle ':chpwd:*' recent-dirs-default true
  zstyle ':chpwd:*' recent-dirs-max 1000
  zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function fzf-cdr () {
  local selected_dir="$(cdr -l | sed 's/^[0-9]* *//' | fzf --height 40% --reverse)"
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N fzf-cdr
bindkey '^O' fzf-cdr

# gitブランチ切り替え
function fzf-git-checkout() {
    local selected_branch=$(git branch -a | fzf --height 40% --reverse | sed -e "s/^\*[ ]*//g" | awk '{print $1}')
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout $selected_branch"
        zle accept-line
    fi
}
zle -N fzf-git-checkout
bindkey '^g^b' fzf-git-checkout

# プロセスをkill
function fzf-kill-process() {
    local pid=$(ps aux | fzf --height 40% --reverse --header-lines=1 | awk '{print $2}')
    if [ -n "$pid" ]; then
        BUFFER="kill $pid"
        zle accept-line
    fi
}
zle -N fzf-kill-process
bindkey '^k' fzf-kill-process

# カレントディレクトリ以下のディレクトリ検索・移動
function find_cd() {
  local selected_dir=$(find . -type d 2>/dev/null | fzf --height 40% --reverse)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N find_cd
bindkey '^X' find_cd

# # gitリポジトリ検索・移動
function fzf-src () {
  local selected_dir=$(ghq list -p | fzf --height 40% --reverse)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}
zle -N fzf-src
bindkey '^G' fzf-src

# fzfのデフォルト設定（オプション）
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
