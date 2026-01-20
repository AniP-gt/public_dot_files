local vim = vim
-- Neovim basic options
local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "no"
opt.termguicolors = true
opt.scrolloff = 8
opt.wrap = false
opt.showtabline = 2 -- Always show tabline for bufferline
opt.conceallevel = 1 -- Balanced: keep Obsidian UI yet show Markdown text
opt.showmode = false -- Don't show mode since we use a statusline plugin

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Search
opt.hlsearch = true
opt.incsearch = true

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Performance
opt.updatetime = 50 -- Keeping 50 as per user's confirmation

-- Spell check (disabled in favor of cspell)
opt.spell = false

-- Cursor
opt.guicursor =
  "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,o:hor50-Cursor/lCursor,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- Environment for Copilot (Node.js)
-- Use system Node.js (no specific path modification)

-- Enable Node.js provider for Copilot
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
-- NOTE: Keep node_provider enabled for Copilot

-- Node.js configuration
vim.g.node_host_prog = vim.env.NVIM_NODE_PATH or vim.fn.exepath("node")

-- Buffer settings
vim.opt.hidden = true -- Allow switching buffers without saving

-- Set colorscheme variant for github theme
vim.g.github_theme_variant = "dark_default"

vim.opt.background = "dark"
vim.opt.shortmess:remove("F") -- Don't hide file info

-- Set LSP log level to ERROR to reduce noise
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = function()
    pcall(vim.lsp.set_log_level, "ERROR")
  end,
})
