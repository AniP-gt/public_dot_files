-- Mermaid diagram preview in terminal using image.nvim and diagram.nvim
return {
  -- Image rendering support (required for diagram.nvim)
  {
    "3rd/image.nvim",
    lazy = true, -- Load only when needed
    opts = {
      backend = "kitty", -- WezTerm supports Kitty graphics protocol
      processor = "magick_rock", -- Use magick luarock (faster) or "magick_cli" for CLI fallback
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
    },
  },

  -- Diagram rendering (Mermaid, PlantUML, etc.)
  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    cmd = { "DiagramToggle", "DiagramRender", "DiagramClear" }, -- Load only when commands are executed
    keys = {
      { "<leader>dm", desc = "Toggle Mermaid diagram preview" },
      { "<leader>dr", desc = "Render Mermaid diagram" },
      { "<leader>dc", desc = "Clear Mermaid diagrams" },
    },
    config = function()
      require("diagram").setup({
        integrations = {
          require("diagram.integrations.markdown"),
          -- require("diagram.integrations.neorg"), -- Uncomment if using neorg
        },
        renderer_options = {
          mermaid = {
            background = "transparent", -- "transparent", "white", or "#RRGGBB"
            theme = "dark", -- "default", "dark", "neutral", "forest"
            scale = 1, -- Increase for higher resolution (2-3 recommended)
          },
        },
      })

      -- Create user commands for easier access
      vim.api.nvim_create_user_command("DiagramToggle", function()
        require("diagram").toggle()
      end, { desc = "Toggle Mermaid diagram preview" })

      vim.api.nvim_create_user_command("DiagramRender", function()
        require("diagram").render()
      end, { desc = "Render Mermaid diagram" })

      vim.api.nvim_create_user_command("DiagramClear", function()
        require("diagram").clear()
      end, { desc = "Clear Mermaid diagrams" })

      -- Keybindings for Mermaid diagrams
      vim.keymap.set("n", "<leader>dm", "<cmd>DiagramToggle<cr>", { desc = "Toggle Mermaid diagram preview" })
      vim.keymap.set("n", "<leader>dr", "<cmd>DiagramRender<cr>", { desc = "Render Mermaid diagram" })
      vim.keymap.set("n", "<leader>dc", "<cmd>DiagramClear<cr>", { desc = "Clear Mermaid diagrams" })
    end,
  },

  -- Mermaid syntax highlighting
  {
    "mracos/mermaid.vim",
    ft = { "mermaid" },
  },
}
