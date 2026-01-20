return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  keys = {
    { "gr", "<cmd>Telescope lsp_references<CR>", desc = "Show references" },
    { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Go to implementation" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature help" },
    { "<space>ca", vim.lsp.buf.code_action, desc = "Code action" },
    { "<space>rn", vim.lsp.buf.rename, desc = "Rename" },
    { "<space>f", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
    { "<leader>li", "<cmd>LspInfo<CR>", desc = "LSP Info" },
    { "<leader>lr", "<cmd>LspRestart<CR>", desc = "LSP Restart" },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- Use utf-16 as it's the most common default for LSP servers
    capabilities.offsetEncoding = "utf-16"

    vim.lsp.enable('stylua', false)
    vim.lsp.config('stylua', { filetypes = {} })
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "stylua" then
          client.stop()
        end
      end,
    })

    -- ESLint
    -- Vue Language Server (vue_ls)
    vim.lsp.config.vue_ls = {
      cmd = { 'vue-language-server', '--stdio' },
      root_markers = { 'package.json' },
      filetypes = { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" },
      capabilities = capabilities,
      settings = {
        typescript = {
          tsdk = vim.env.NVIM_NODE_PATH and vim.env.NVIM_NODE_PATH:match("(.*)/[^/]+/bin/node$") and (vim.env.NVIM_NODE_PATH:match("(.*)/[^/]+/bin/node$") .. "lib/node_modules/typescript/lib") or nil
        },
        vue = {
          hybridMode = false,
        },
      },
    }
    vim.lsp.enable('vue_ls')

    vim.lsp.config.eslint = {
      cmd = vim.env.NVIM_NODE_PATH and { vim.env.NVIM_NODE_PATH, vim.env.HOME .. "/.local/share/nvim/mason/packages/eslint-lsp/node_modules/vscode-langservers-extracted/bin/vscode-eslint-language-server", "--stdio" } or { 'vscode-eslint-language-server', '--stdio' },
      root_markers = { 'package.json', '.eslintrc.js', '.eslintrc.json' },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      capabilities = capabilities,
      settings = {
        workingDirectories = { mode = "auto" },
        format = false,
      },
      on_init = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }
    vim.lsp.enable('eslint')

    -- TypeScript
    vim.lsp.config.ts_ls = {
      cmd = vim.env.NVIM_NODE_PATH and { vim.env.NVIM_NODE_PATH, vim.env.HOME .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.mjs", "--stdio" } or { 'typescript-language-server', '--stdio' },
      root_markers = { 'package.json', 'tsconfig.json' },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "literal",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayEnumMemberValueHints = false,
          },
          preferences = {
            disableSuggestions = false,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "literal",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = false,
            includeInlayPropertyDeclarationTypeHints = false,
            includeInlayFunctionLikeReturnTypeHints = false,
            includeInlayEnumMemberValueHints = false,
          },
        },
      },
      on_init = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
    }
    vim.lsp.enable('ts_ls')

    -- Lua
    vim.lsp.config.lua_ls = {
      cmd = { 'lua-language-server' },
      root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml' },
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
    vim.lsp.enable('lua_ls')

    -- Ruby LSP (instead of Solargraph which crashes with Ruby 3.2.0 on ARM)
    vim.lsp.config.ruby_lsp = {
      cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
      filetypes = { "ruby" },
      root_markers = { "Gemfile", ".git" },
      capabilities = capabilities,
      init_options = {
        enabledFeatures = {
          "codeActions",
          "diagnostics",
          "documentHighlights",
          "documentLink",
          "documentSymbols",
          "foldingRanges",
          "formatting",
          "hover",
          "inlayHints",
          "onTypeFormatting",
          "selectionRanges",
          "semanticHighlighting",
          "completion",
          "codeLens",
          "definition",
          "workspaceSymbols",
        },
        formatter = "auto",
      },
    }
    vim.lsp.enable('ruby_lsp')

    -- CSpell LSP (installed via Mason) - Re-enabled with Japanese filtering
    vim.lsp.config.cspell = {
      cmd = { vim.fn.stdpath("data") .. "/mason/bin/cspell-lsp", "--stdio" },
      filetypes = {
        "javascript", "javascriptreact", "typescript", "typescriptreact",
        "python", "lua", "sh", "markdown", "text", "gitcommit",
        "json", "yaml", "html", "css", "vue", "ruby"
      },
      root_markers = { 'cspell.json', '.cspell.json', 'package.json', '.git' },
      capabilities = capabilities,
      settings = {
        cspell = {
          diagnosticLevel = "Warning",
          -- Filter out Japanese characters
          ignoreRegExpList = {
            -- Hiragana
            "[\\u3040-\\u309F]+",
            -- Katakana
            "[\\u30A0-\\u30FF]+",
            -- Kanji
            "[\\u4E00-\\u9FFF]+",
            -- Full-width characters
            "[\\uFF00-\\uFFEF]+",
            -- Japanese punctuation
            "[\\u3000-\\u303F]+",
            -- Combined Japanese
            "[ぁ-んァ-ヶー一-龠々〜・]+",
            -- Japanese punctuation marks
            "[、。「」『』（）｛｝［］【】〈〉《》〔〕｟｠]+"
          }
        },
      }
    }
    vim.lsp.enable('cspell')

    -- Golang
    vim.lsp.config.gopls = {
      filetypes = { 'go', 'gomod', 'gowork', 'gohtmltmpl' },
      root_markers = { 'go.mod', '.git' },
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          staticcheck = true,
        },
      },
    }
    vim.lsp.enable('gopls')

    -- Clangd (C/C++/Objective-C/Objective-C++)
    vim.lsp.config.clangd = {
      cmd = { 'clangd', '--background-index', '--clang-tidy', '--header-insertion=iwyu' },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
      root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
      capabilities = capabilities,
      settings = {
        clangd = {
          fallbackFlags = { "-std=c++17" },
        },
      },
    }
    vim.lsp.enable('clangd')

    -- SourceKit-LSP (Swift)
    vim.lsp.config.sourcekit = {
      cmd = { 'sourcekit-lsp' },
      filetypes = { "swift" },
      root_markers = { "Package.swift", ".git" },
      capabilities = capabilities,
    }
    vim.lsp.enable('sourcekit')
  end,
}
