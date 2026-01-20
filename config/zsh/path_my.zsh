#!/usr/bin/env zsh

# Volta設定
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# golangのパス
export PATH=$PATH:~/go/bin

# Neovim用のNode.jsパス
export NVIM_NODE_PATH="~/.volta/tools/image/node/22.17.0/bin/node"

# .local/binの設定
# 例) posting, uvx
export PATH="~/.local/bin:$PATH"

# Google CLIの設定
export PATH=/opt/homebrew/share/google-cloud-sdk/bin:"$PATH"

export LDFLAGS="-L/opt/homebrew/opt/libiconv/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libiconv/include"
