return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text" },
  config = function()
    local autolist = require("autolist")
    autolist.setup()

    -- Markdown などで Enter で次の箇条書きを自動生成
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "text" },
      callback = function(ev)
        -- 挿入モードで Enter を押したときに次の bullet を作成
        vim.keymap.set(
          "i",
          "<CR>",
          "<CR><cmd>AutolistNewBullet<CR>",
          { buffer = ev.buf, silent = true }
        )

        -- Backspace で空の bullet 行を削除したいときなど、
        -- 追加でほしくなったらここでキーを増やせます。
      end,
    })
  end,
}
