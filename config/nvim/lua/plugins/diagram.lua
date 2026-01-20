return {
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

      end,
}
