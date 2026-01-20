local vim = vim
-- Neovim autocommands
local api = vim.api

-- Highlight settings
api.nvim_set_hl(0, "Cursor", { bg = "#ffffff", fg = "#000000" })
api.nvim_set_hl(0, "lCursor", { bg = "#ffffff", fg = "#000000" })

local function configure_diagnostics()
  vim.diagnostic.config({
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "󰅚 ",
        [vim.diagnostic.severity.WARN] = "󰀪 ",
        [vim.diagnostic.severity.HINT] = "󰌶 ",
        [vim.diagnostic.severity.INFO] = " ",
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  once = true,
  callback = configure_diagnostics,
})

-- Spell check appearance (kept for cspell diagnostics)
api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#ff0000" })
api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#ffaa00" })
api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = "#00aaff" })
api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = "#00ff00" })

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Disable LazyVim's automatic spell check
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")
    vim.opt.spell = false
  end,
})

-- Force disable spell check on all buffers
autocmd({ "BufEnter", "BufWinEnter", "FileType" }, {
  group = augroup("force_disable_spell", { clear = true }),
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- Suppress warnings on startup
autocmd("VimEnter", {
  group = augroup("suppress_warnings", { clear = true }),
  callback = function()
    -- Clear any existing messages after startup
    vim.defer_fn(function()
      vim.cmd("messages clear")
    end, 1000)
  end,
})

-- Suppress transport warnings specifically
autocmd("User", {
  pattern = "LazyVimStarted",
  group = augroup("clear_startup_messages", { clear = true }),
  callback = function()
    -- Clear messages after LazyVim has started
    vim.schedule(function()
      vim.cmd("messages clear")
    end)
  end,
})

-- Better error handling for LSP
autocmd("LspAttach", {
  group = augroup("lsp_config", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Ensure conceallevel is set for markdown buffers (for obsidian and render-markdown)
autocmd("FileType", {
  pattern = "markdown",
  group = augroup("markdown_conceal", { clear = true }),
  callback = function()
    vim.wo.conceallevel = 1
  end,
})
