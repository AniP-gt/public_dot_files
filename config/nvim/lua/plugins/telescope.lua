return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = true,
  cmd = { "Telescope", "TelescopeCommandHistory" },
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fc", "<cmd>TelescopeCommandHistory<cr>", desc = "Command history" },

  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        layout_config = {
          horizontal = {
            preview_cutoff = 120,
            width = 0.9,
            height = 0.9,
          },
          vertical = {
            width = 0.9,
            height = 0.9,
          },
        },
        path_display = { "truncate" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        file_ignore_patterns = {
          "node_modules/",
          ".git/",
          ".DS_Store",
          "*.lock",
          "dist/",
          "build/",
          "coverage/",
          ".next/",
          ".nuxt/",
          ".cache/",
          "*.min.js",
          "*.min.css",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<CR>"] = actions.select_default + actions.center,
          },
          n = {
            ["<CR>"] = actions.select_default + actions.center,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })

    telescope.load_extension("fzf")

    -- Custom command history picker
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local action_state = require("telescope.actions.state")

    local function command_history()
      pickers
        .new({}, {
          prompt_title = "Command History",
          finder = finders.new_table({
            results = vim.fn.split(vim.fn.execute("history :", "v"), "\n"),
            entry_maker = function(entry)
              -- Parse history format: "  123  command"
              local num, cmd = entry:match("^%s*(%d+)%s+(.+)$", 1)
              if cmd then
                return {
                  value = cmd,
                  display = cmd,
                  ordinal = cmd,
                }
              end
            end,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              if selection then
                -- Put command in command line without executing
                vim.fn.feedkeys(":" .. selection.value, "n")
              end
            end)
            return true
          end,
        })
        :find()
    end

    -- Register the custom command
    vim.api.nvim_create_user_command("TelescopeCommandHistory", command_history, {})
  end,
}
