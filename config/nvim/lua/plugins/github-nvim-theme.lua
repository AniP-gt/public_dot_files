return {
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          compile_path = vim.fn.stdpath("cache") .. "/github-theme",
          compile_file_suffix = "_compiled",
          hide_end_of_buffer = true,
          hide_nc_statusline = true,
          transparent = true,
          terminal_colors = true,
          dim_inactive = false,
          module_default = true,
          styles = {
            comments = "italic",
            functions = "NONE",
            keywords = "NONE",
            variables = "NONE",
            conditionals = "NONE",
            constants = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
          },
          inverse = {
            match_paren = false,
            visual = false,
            search = false,
          },
          darken = {
            floats = false,
            sidebars = {
              enable = true,
              list = { "qf", "vista_kind", "packer", "nvim-tree" },
            },
          },
          modules = {
            cmp = true,
            diagnostic = {
              enable = true,
              background = true,
            },
            gitsigns = true,
            native_lsp = {
              enable = true,
              background = true,
            },
            telescope = true,
            treesitter = true,
            whichkey = true,
            nvim_tree = true,
            lsp_trouble = true,
            indent_blankline = true,
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      vim.cmd.colorscheme("github_dark_default")

      local function apply_tree_highlights()
        local tree_bg = "#0d1117"
        local border_fg = "#0d1117"

        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = tree_bg })
        vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = tree_bg })
        vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = tree_bg })
        vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = tree_bg, fg = border_fg })
        vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = tree_bg, fg = border_fg })

        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = tree_bg })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = tree_bg })
        vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = tree_bg })
        vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = tree_bg, fg = border_fg })

        vim.g.terminal_color_7 = "#FFFFFF"
        vim.g.terminal_color_15 = "#FFFFFF"
      end

      apply_tree_highlights()

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "github_dark_default",
        callback = apply_tree_highlights,
      })
    end,
  },
}
