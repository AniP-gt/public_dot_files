#!/usr/bin/env zsh

# Zinit プラグインマネージャーの設定

# Zinitのインストールパス
ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

# Zinitの自動インストール
_install_zinit() {
    if [[ ! -f "${ZINIT_HOME}/zinit.zsh" ]]; then
        print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
        command mkdir -p "$(dirname ${ZINIT_HOME})" && command chmod g-rwX "$(dirname ${ZINIT_HOME})"
        command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}" && \
            print -P "%F{33} %F{34}Installation successful.%f%b" || \
            print -P "%F{160} The clone has failed.%f%b"
    fi
}

# Zinitの初期化
_init_zinit() {
    source "${ZINIT_HOME}/zinit.zsh"
    autoload -Uz _zinit
    (( ${+_comps} )) && _comps[zinit]=_zinit
}

# プラグインの読み込み
_load_plugins() {
    # Powerlevel10k テーマ
    zinit ice depth=1
    zinit light romkatv/powerlevel10k

    # コマンド補完（遅延読み込み）
    zinit ice wait'0'
    zinit light zsh-users/zsh-completions

    # シンタックスハイライト
    zinit light zsh-users/zsh-syntax-highlighting

    # 履歴補完
    zinit light zsh-users/zsh-autosuggestions

    # 履歴補完のスタイル設定
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"
}

# Powerlevel10k設定の読み込み
_load_p10k_config() {
    local p10k_config="${HOME}/.config/p10k/p10k.zsh"
    [[ -f "$p10k_config" ]] && source "$p10k_config"
}

# メイン処理
main() {
    _install_zinit
    _init_zinit
    _load_plugins
    _load_p10k_config
}

main