# google検索
# google() { open /Applications/Google\ Chrome.app/ "http://www.google.com/search?q= $1"; }
google() { open /Applications/Microsoft\ Edge.app/ "http://www.google.com/search?q= $1"; }

alias g="google"

# claude codeのエイリアス
alias cla="claude"
alias clad="claude --dangerously-skip-permissions"

# opencodeのエイリアス
alias oc="opencode"

# tmuxのエイリアス
alias tm="tmux"
alias tms="tmux new -s"
alias tma="tmux attach -t"
alias tml="tmux ls"
alias tmk="tmux kill-session -t"

# brew のエイリアス
alias update_brew='brew update && brew upgrade && brew cleanup && brew doctor'

# zenn cli のエイリアス　
alias zenn-new='npx zenn new:article'

# ---- TheFuck -----
# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# ---- zoxide -----
eval "$(zoxide init zsh)"

# cdコマンドのオーバーライド
# zoixdeで失敗した場合は元のcdコマンドを実行
cd() {
  if [ -d "$1" ]; then
    builtin cd "$1" || return
    zoxide add "$PWD"  # ついでにzoxideに記録
  else
    zoxide query "$1" >/dev/null 2>&1 && builtin cd "$(zoxide query "$1")" || {
      echo "Directory not found: $1"
      return 1
    }
  fi
}

# lsのエイリアス
# alias ls='ls -FG'

# ncduのエイリアス
alias ncdu="ncdu --color dark"

# ---- Bat (better cat) -----
alias cat="bat"

# ---- Eza (better ls) -----

alias ls="eza --icons=always"

# キャッシュ削除
alias rm_cache='sudo rm -rf ~/Library/Caches/*  ~/.cache/* ~/.Trash/* && echo "Cache cleared!"'
alias rm_clearcache_heavy='sudo rm -rf ~/Library/Caches/*  ~/.cache/* ~/.Trash/* && brew cleanup -s && docker system prune -af && echo "Heavy cache cleared!"'

# grepのエイリアス
# highlight search
alias grep='grep --color=auto'

# openのエイリアス
alias o='open'

# cd ..のエイリアス
alias ..='cd ..'

# prompt before overwrite
alias cp='cp -i'

alias mv='mv -i'

# ask before deleting
alias rm='rm -i'

# human readable file sizes
alias df='df -h'

# human readable disk usage
alias du='du -h -d 1'

# memory usage
alias free='free -m'

# neovimのエイリアス
alias vim='nvim'
alias vi='nvim'

# lazgygitのエイリアス
alias lg='lazygit'

# lazgydockerのエイリアス
alias ld='lazydocker'

# lazysqlのエイリアス
alias lsql='lazysql'

# openhands CLIのエイリアス
alias openhands='uvx --python 3.12 --from openhands-ai openhands'

#dockerのエイリアス
alias dc='docker compose'
alias dcbuild='docker compose build'
alias dcbuildn='docker compose build --no-cache'
alias dcps='docker compose ps'
alias dcup='docker compose up'
alias dcupd='docker compose up -d'
alias dcex='docker compose exec'
alias dcrun='docker compose run --rm'
alias dcdown='docker compose down'
alias dcl='docker compose logs'
alias dcbe='docker compose exec app bundle exec'
alias dcber='docker compose exec app bundle exec rails'
alias dcbes='docker compose run --rm -e RAILS_ENV=test app bundle exec rspec'

#Gitのエイリアス
alias gb='git branch'
alias gc='git checkout'
alias gs='git status'
alias gm='git commit -m'
alias ga='git add'
alias gl='git log'
alias gf='git fetch origin'
alias gpl='git pull origin'
alias gch='git cherry-pick'
alias gconf='git config --list'
