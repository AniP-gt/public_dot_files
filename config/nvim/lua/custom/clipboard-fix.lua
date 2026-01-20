-- Clipboard fix for Visual mode issues
local M = {}

-- Store the original clipboard setting
M.setup = function()
  -- Simple and reliable approach
  vim.keymap.set("x", "<leader>y", function()
    -- Yank to internal register first
    vim.cmd('normal! "zy')
    -- Get the content
    local text = vim.fn.getreg("z")
    -- Copy to clipboard using pbcopy
    vim.fn.system("pbcopy", text)
    -- Exit visual mode
    vim.cmd("normal! \\<Esc>")
    -- Optional notification
    print("Yanked to clipboard")
  end, { desc = "Yank to system clipboard (fixed)", noremap = true, silent = true })
end

return M

