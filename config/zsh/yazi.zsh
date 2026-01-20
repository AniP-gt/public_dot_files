# ---------- Yazi設定 -------------
# Yaziのシェル統合: yaziを抜けた時にcdした場所に移動
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# yaコマンド: ディレクトリ移動なしでyaziを起動
alias ya='yazi'
