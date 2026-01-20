# shellコマンドの補完
# Edit Command
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^[e' edit-command-line

# Push Command
bindkey '^U' push-line

# history begining search
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
