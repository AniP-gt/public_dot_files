local vim = vim
local keymap = vim.keymap.set

-- Posting

keymap("n", "<leader>po", function()

  -- Set white border color for posting

  vim.cmd("highlight PostingBorder guifg=#FFFFFF ctermfg=15 guibg=NONE ctermbg=NONE")



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

    title = " Posting ",

    title_pos = "center",

  })



  vim.api.nvim_set_option_value("winhighlight", "Normal:Normal,FloatBorder:PostingBorder", { win = win })



  vim.fn.termopen("posting", {

    on_exit = function()

      if vim.api.nvim_win_is_valid(win) then

        vim.api.nvim_win_close(win, true)

      end

      if vim.api.nvim_buf_is_valid(buf) then

        vim.api.nvim_buf_delete(buf, { force = true })

      end

    end,

  })



  -- Set options for the new window

  vim.wo.list = true

  vim.wo.spell = true

   vim.api.nvim_set_option_value("conceallevel", 2, { win = win })

  vim.cmd("startinsert")

end, { desc = "Open Posting" })