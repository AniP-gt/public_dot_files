local lazydocker_terms = {}

local function toggle_lazydocker(direction)
  local Terminal = require("toggleterm.terminal").Terminal
  local key = direction or "float"
  if not lazydocker_terms[key] then
    local opts = {
      cmd = "lazydocker",
      direction = direction or "float",
      hidden = true,
    }
    if direction == "vertical" then
      opts.size = 80
    end
    lazydocker_terms[key] = Terminal:new(opts)
  end
  lazydocker_terms[key]:toggle()
end

return {

  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm" },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    shade_terminals = false,
    shading_factor = 1,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
      border = "double",
      winblend = 0,
      width = math.floor(vim.o.columns * 0.9),
      height = math.floor(vim.o.lines * 0.9),
    },
    highlights = {
      Normal = {
        link = "Normal",
      },
      NormalFloat = {
        link = "NormalFloat",
      },
      FloatBorder = {
        fg = "#FFFFFF",
      },
    },
  },
  keys = {
    { "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal" },
    { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
    {
      "<leader>ld",
      function()
        toggle_lazydocker("float")
      end,
      desc = "Docker (LazyDocker)",
    },
    {
      "<leader>dd",
      function()
        toggle_lazydocker("float")
      end,
      desc = "Docker (LazyDocker)",
    },
    {
      "<leader>ds",
      function()
        toggle_lazydocker("vertical")
      end,
      desc = "Open LazyDocker (split)",
    },
    {
      "<leader>do",
      function()
        local Terminal = require("toggleterm.terminal").Terminal
        local oxker = Terminal:new({
          cmd = "oxker",
          dir = "git_dir",
          direction = "float",
          float_opts = {
            border = "curved",
            width = math.floor(vim.o.columns * 0.9),
            height = math.floor(vim.o.lines * 0.9),
          },
          on_open = function(term)
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-q>", "<cmd>close<CR>", { noremap = true, silent = true })
          end,
          on_close = function(term)
            vim.cmd("startinsert!")
          end,
          hidden = true,
        })
        oxker:toggle()
      end,
      desc = "Open Oxker (Docker TUI)",
    },
    { "<leader>gdd", "<cmd>lua git_delta_diff()<cr>", desc = "Git diff with delta" },
    { "<leader>gds", "<cmd>lua git_delta_staged()<cr>", desc = "Git staged diff with delta" },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Create a custom terminal for git-delta
    local Terminal = require("toggleterm.terminal").Terminal

    local delta_diff = Terminal:new({
      cmd = "git diff | delta --side-by-side",
      direction = "float",
      float_opts = {
        border = "double",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "q", "<cmd>close<CR>", {
          buffer = term.bufnr,
          noremap = true,
          silent = true,
        })
      end,
    })

    -- Function to show git delta diff
    function _G.git_delta_diff()
      delta_diff:toggle()
    end

    -- Function to show staged diff with delta
    local delta_staged = Terminal:new({
      cmd = "git diff --staged | delta --side-by-side",
      direction = "float",
      float_opts = {
        border = "double",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })

    function _G.git_delta_staged()
      delta_staged:toggle()
    end

    -- Set terminal keymaps
    function _G.set_terminal_keymaps()
      local kopts = { buffer = 0 }
      vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], kopts)
      vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode (alt)", buffer = 0 })
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], kopts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], kopts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], kopts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], kopts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
