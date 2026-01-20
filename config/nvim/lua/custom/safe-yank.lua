-- Safe yank to clipboard for tmux environment
local M = {}

M.setup = function()
  -- Safe visual mode mapping that preserves selection
  vim.keymap.set("v", "<leader>y", function()
    vim.cmd('normal! "vy')
    local text = vim.fn.getreg("v")
    vim.fn.system("pbcopy", text)
    print("Selection yanked to clipboard")
  end, {
    desc = "Yank selection to clipboard",
    silent = true,
  })

  -- Alternative: Direct command without visual mode issues
  vim.keymap.set("n", "<leader>yy", function()
    vim.cmd("normal! yy")
    local text = vim.fn.getline(".")
    vim.fn.system("pbcopy", text)
    print("Line yanked to clipboard")
  end, { desc = "Yank line to clipboard", silent = true })
end

return M

