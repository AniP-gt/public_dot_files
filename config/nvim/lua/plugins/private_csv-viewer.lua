local M = {}

-- Function to open CSV file in tabiew using floating terminal
M.open_tabiew = function(filepath)
  filepath = filepath or vim.fn.expand("%:p")

  if filepath == "" then
    vim.notify("No file open", vim.log.levels.WARN)
    return
  end

  -- Create a new buffer for the terminal
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)
  local row = math.floor(vim.o.lines * 0.05)
  local col = math.floor(vim.o.columns * 0.05)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "double",
  })

  -- Set buffer options
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })

  -- Open terminal with tabiew
  vim.fn.termopen("tw " .. vim.fn.shellescape(filepath), {
    on_exit = function()
      pcall(vim.api.nvim_win_close, win, true)
    end,
  })

  -- Set keymaps for the terminal window
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

  -- Enter insert mode
  vim.cmd("startinsert")
end

return {
  "nvim-lua/plenary.nvim", -- Dummy plugin to attach the config and keymaps
  dependencies = {
    -- No actual plugin needed, just for dependencies
  },
  keys = {
    {
      "<leader>cv",
      function()
        M.open_tabiew()
      end,
      desc = "Open CSV in tabiew",
    },
  },
  config = function()
    _G.csv_viewer = M -- Make the module globally accessible

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "csv" },
      callback = function()
        vim.keymap.set("n", "<leader>cv", function()
          M.open_tabiew()
        end, { buffer = true, desc = "Open in tabiew" })
      end,
    })
  end,
}
