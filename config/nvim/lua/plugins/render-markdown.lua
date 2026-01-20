return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  ft = "markdown",
  opts = {
    -- デフォルトでレンダリングを有効にする
    enabled = true,
    -- ノーマルモードとビジュアルモードでレンダリング
    render_modes = { "n", "v" },
    -- ヘッダーの背景を有効化
    heading = {
      enabled = true,
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    -- コードブロックのスタイリング
    code = {
      enabled = true,
      sign = true,
      style = "full",
    },
    -- テーブルのスタイリング
    pipe_table = {
      enabled = true,
      style = "full",
    },
    -- チェックボックスのカスタマイズ
    checkbox = {
      enabled = true,
      unchecked = { icon = "○ " },
      checked = { icon = "◉ " },
    },
    -- conceallevel を obsidian と互換させる
    win_options = {
      conceallevel = {
        default = 1,
        rendered = 1,
      },
    },
  },
}
