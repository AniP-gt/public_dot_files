return {
  "stevearc/overseer.nvim",
  keys = {
    { "<leader>osr", "<cmd>OverseerRun<cr>", desc = "Run task" },
    { "<leader>ost", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
    { "<leader>osa", "<cmd>OverseerTaskAction<cr>", desc = "Task actions" },
    { "<leader>osb", "<cmd>OverseerBuild<cr>", desc = "Build task" },
    {
      "<leader>oso",
      function()
        require("overseer"):open()
      end,
      desc = "Open task list",
    },
    {
      "<leader>osc",
      function()
        require("overseer"):close()
      end,
      desc = "Close task list",
    },
    {
      "<leader>osq",
      function()
        require("overseer"):quick_action()
      end,
      desc = "Quick task action",
    },
    { "<leader>osl", "<cmd>OverseerLoadBundle<cr>", desc = "Load task bundle" },
    { "<leader>oss", "<cmd>OverseerSaveBundle<cr>", desc = "Save task bundle" },
  },
  config = function(_, opts)
    require("overseer").setup(vim.tbl_extend("force", opts or {}, {
      templates = {
        builtin = true,
      },
      component_aliases = {
        default = {
          { "display_duration", detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_notify",
          "on_complete_dispose",
        },
      },
      task_list = {
        direction = "bottom",
        min_height = 10,
        max_height = 20,
        default_detail = 1,
        bindings = {
          ["<C-v>"] = "OpenVsplit",
          ["<C-s>"] = "OpenSplit",
          ["<C-f>"] = "OpenFloat",
          ["o"] = "Open",
          ["<cr>"] = "Open",
        },
      },
      -- Force terminal strategy
      strategy = {
        "toggleterm",
        direction = "horizontal",
        open_on_start = true,
        quit_on_exit = "never",
      },
    }))

    -- RSpec template with terminal output
    require("overseer").register_template({
      name = "rspec current file",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "bundle", "exec", "rspec", file },
          name = "rspec " .. vim.fn.expand("%:t"),
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- RSpec nearest test
    require("overseer").register_template({
      name = "rspec nearest",
      builder = function()
        local file = vim.fn.expand("%:p")
        local line = vim.fn.line(".")
        return {
          cmd = { "bundle", "exec", "rspec", file .. ":" .. line },
          name = "rspec nearest " .. vim.fn.expand("%:t"),
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- Rails server with terminal
    require("overseer").register_template({
      name = "rails server",
      builder = function()
        return {
          cmd = { "rails", "server" },
          name = "rails server",
          components = {
            "default",
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- Jest coverage all
    require("overseer").register_template({
      name = "jest coverage all",
      builder = function()
        return {
          cmd = { "yarn", "jest", "--coverage" },
          name = "jest coverage all",
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- Jest coverage current file
    require("overseer").register_template({
      name = "jest coverage file",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "yarn", "jest", "--coverage", file },
          name = "jest coverage " .. vim.fn.expand("%:t"),
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- Docker RSpec current file
    require("overseer").register_template({
      name = "docker rspec file",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "docker", "compose", "run", "--rm", "app", "rspec", file },
          name = "docker rspec " .. vim.fn.expand("%:t"),
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- Docker RSpec nearest test
    require("overseer").register_template({
      name = "docker rspec nearest",
      builder = function()
        local file = vim.fn.expand("%:p")
        local line = vim.fn.line(".")
        return {
          cmd = { "docker", "compose", "run", "--rm", "app", "rspec", file .. ":" .. line },
          name = "docker rspec nearest " .. vim.fn.expand("%:t"),
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })

    -- Docker Rubocop auto-correct
    require("overseer").register_template({
      name = "docker rubocop fix",
      builder = function()
        local file = vim.fn.expand("%:p")
        return {
          cmd = { "docker", "compose", "run", "--rm", "app", "rubocop", "-a", file },
          name = "docker rubocop fix " .. vim.fn.expand("%:t"),
          components = {
            "default",
            { "on_output_quickfix", open = true },
            { "on_complete_notify", statuses = { "FAILURE" } },
            { "open_output", on_start = "always", focus = false },
          },
        }
      end,
    })
  end,
}
