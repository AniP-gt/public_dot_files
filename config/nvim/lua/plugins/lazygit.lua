return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>lg",
      function()
        -- Set white border color for lazygit window
        vim.cmd("highlight LazyGitBorder guifg=#FFFFFF ctermfg=15 guibg=NONE ctermbg=NONE")

        -- Set terminal colors for lazygit internal panels
        vim.g.terminal_color_7 = "#FFFFFF" -- white
        vim.g.terminal_color_15 = "#FFFFFF" -- bright white

        local buf = vim.api.nvim_create_buf(false, true)
        local width = math.floor(vim.o.columns * 0.9)
        local height = math.floor(vim.o.lines * 0.9)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        local win = vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
        })

        vim.api.nvim_set_option_value("winhighlight", "Normal:Normal,FloatBorder:LazyGitBorder", { win = win })

        vim.fn.termopen("lazygit", {
          on_exit = function()
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_close(win, true)
            end
            if vim.api.nvim_buf_is_valid(buf) then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end,
        })
        vim.cmd("startinsert")
      end,
      desc = "Open LazyGit",
    },
    {
      "<leader>gc",
      function()
        -- Force close all floating windows
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_is_valid(win) then
            local ok, config = pcall(vim.api.nvim_win_get_config, win)
            if ok and config.relative ~= "" then
              pcall(vim.api.nvim_win_close, win, true)
            end
          end
        end

        -- Delete any remaining terminal/lazygit buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) then
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("lazygit") or name:match("term://") then
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
          end
        end

        vim.cmd("redraw!")
        print("LazyGit cleanup completed")
      end,
      desc = "Force cleanup LazyGit windows",
    },
  },
}
