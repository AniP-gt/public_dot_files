return {

  -- Alternative: Use external diff tool in terminal
  {
    "akinsho/toggleterm.nvim",
    config = function()
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
            silent = true
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
    end,
    keys = {
      { "<leader>gdd", "<cmd>lua git_delta_diff()<cr>", desc = "Git diff with delta" },
      { "<leader>gds", "<cmd>lua git_delta_staged()<cr>", desc = "Git staged diff with delta" },
    },
  },
}