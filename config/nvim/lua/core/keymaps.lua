-- Unified Neovim keymaps
local vim = vim
local keymap = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
keymap("n", "H", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
keymap("n", "L", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

-- Window navigation with leader
keymap("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })

-- Window splits

keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertically" })

keymap("n", "<leader>sh", ":split<CR>", { desc = "Split horizontally" })

keymap("n", "<leader>sc", ":close<CR>", { desc = "Close split" })

keymap("n", "<leader>so", ":only<CR>", { desc = "Close other splits" })

-- Diagnostics

keymap("n", "<leader>dl", ":lua vim.diagnostic.setloclist()<CR>", { desc = "Open diagnostic location list" })

keymap("n", "<leader>df", ":lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostic float" })

keymap("n", "<leader>dn", ":lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic" })

keymap("n", "<leader>dp", ":lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostic" })

-- Spell check

keymap("n", "<leader>ss", ":setlocal spell!<CR>", { desc = "Toggle spell check" })

keymap("n", "<leader>sn", "]s", { desc = "Next misspelling" })

keymap("n", "<leader>sp", "[s", { desc = "Previous misspelling" })

keymap("n", "<leader>sa", "zg", { desc = "Add word to dictionary" })

keymap("n", "<leader>sf", "z=", { desc = "Suggest corrections" })

keymap("n", "<leader>sr", "zug", { desc = "Remove word from dictionary" })

-- File operations

keymap("n", "<leader>cp", "<cmd>let @+ = expand('%:p')<CR>", { desc = "Copy absolute file path" })

keymap("n", "<leader>cr", "<cmd>let @+ = expand('%')<CR>", { desc = "Copy relative file path" })

keymap("n", "<leader>cf", "<cmd>let @+ = expand('%:t')<CR>", { desc = "Copy filename" })

keymap("n", "<leader>cl", "<cmd>let @+ = expand('%:p') . ':' . line('.')<CR>", { desc = "Copy path with line number" })

-- Defer macOS-specific file operations to reduce startup overhead
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    -- Open file/directory in Finder (macOS)
    keymap("n", "<leader>of", function()
      local file_path = vim.fn.expand("%:p")
      if file_path ~= "" then
        vim.fn.system('open -R "' .. file_path .. '"')
      else
        vim.fn.system('open "' .. vim.fn.getcwd() .. '"')
      end
    end, { desc = "Open file in Finder" })

    keymap("n", "<leader>od", function()
      local dir_path = vim.fn.expand("%:p:h")
      if dir_path ~= "" then
        vim.fn.system('open "' .. dir_path .. '"')
      else
        vim.fn.system('open "' .. vim.fn.getcwd() .. '"')
      end
    end, { desc = "Open directory in Finder" })

    -- Quicklook (macOS)
    local function quicklook_preview()
      local filepath = vim.fn.expand("%:p")
      if filepath ~= "" then
        local cmd = string.format(
          [[
          qlmanage -p %s >/dev/null 2>&1 &
          sleep 0.2
          osascript -e 'tell application "System Events" to set frontmost of first process whose name contains "qlmanage" to true'
        ]],
          vim.fn.shellescape(filepath)
        )
        vim.fn.system(cmd)
      else
        vim.notify("No file to preview", vim.log.levels.WARN)
      end
    end

    keymap("n", "<leader>ql", quicklook_preview, { desc = "Quicklook current file" })
  end,
})

-- System clipboard operations
keymap({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })
keymap({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })

-- Better paste
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Quick save and quit
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
keymap("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all" })
keymap("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })

-- Clear search highlight
keymap("n", "<leader>/", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better indenting
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up/down
keymap("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
keymap("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Resize windows
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase width" })
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Decrease height" })
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Increase height" })

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Debug commands
keymap("n", "<leader>dm", "<cmd>messages<CR>", { desc = "Show messages" })
keymap("n", "<leader>dc", "<cmd>messages clear<CR>", { desc = "Clear messages" })

-- Quickfix/Location list management
keymap("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
keymap("n", "<leader>qo", "<cmd>copen<CR>", { desc = "Open quickfix" })
keymap("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })
keymap("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open location list" })

-- Diagnostic navigation (additional)
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
keymap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })
