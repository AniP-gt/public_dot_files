-- Keymaps for the external 'lazysql' command-line tool
-- This file is not a lazy.nvim plugin spec, but a simple script
-- that gets required manually.

local keymap = vim.keymap.set

keymap("n", "<leader>sq", function()
  vim.cmd("vsplit")
  vim.cmd("terminal lazysql")
  vim.cmd("startinsert")
end, { desc = "Open LazySQL (split)" })

keymap("n", "<leader>db", function()
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

  -- Set proper border colors to prevent flickering
  vim.api.nvim_set_option_value("winhighlight", "Normal:Normal,FloatBorder:FloatBorder", { win = win })

  vim.fn.termopen("lazysql", {
    on_exit = function()
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })
  vim.cmd("startinsert")
end, { desc = "Database (LazySQL)" })
