# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# .config/ を見るようにするexport
export XDG_CONFIG_HOME="$HOME/.config"

# ----- 個人PC用------
source ~/.config/zsh/path_my.zsh

# ---------- 共通関数 -------------
source ~/.config/zsh/functions.zsh

# ---------- 履歴設定 -------------
source ~/.config/zsh/history.zsh

#----------- エイリアス ------------
source ~/.config/zsh/alias.zsh

#----------- bindkey ------------
source ~/.config/zsh/bindkey.zsh

# ---------- Git設定 -------------
source ~/.config/zsh/git.zsh

# ---------- fzf設定 -------------
source ~/.config/zsh/zshrc_fzf_functions.zsh

# ---------- Zinit設定 -------------
source ~/.config/zsh/zinit.zsh

# ---------- Yazi設定 -------------
source ~/.config/zsh/yazi.zsh

# ---------- Tmuxの設定 -----------
source ~/.config/zsh/tmux.zsh

