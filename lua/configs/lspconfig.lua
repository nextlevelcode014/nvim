local nvlsp = require "nvchad.configs.lspconfig"

-- Lista de servidores LSP para habilitar
local servers = {
  "html",
  "cssls",
  "clangd",
  "ts_ls",
  "pylsp",
  "rust_analyzer",
  "emmet_ls",
  "tailwindcss",
  "eslint",
  "jsonls",
  "yamlls",
  "bashls",
}

-- Habilitar os servidores LSP usando a nova API
vim.lsp.enable(servers)

-- Autocomando LspAttach para configurações quando o LSP se conecta
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Chama a função on_attach padrão do NvChad
    nvlsp.on_attach(client, bufnr)

    -- Configurações específicas por cliente
    if client.name == "ts_ls" then
      -- Desabilitar formatação do ts_ls (usar prettier via conform)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    if client.name == "eslint" then
      -- Auto-fix ESLint ao salvar
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end
  end,
})

-- Configurações específicas para Python (pylsp)
vim.lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        mccabe = { enabled = false },
        pyflakes = { enabled = false },
        flake8 = { enabled = true, maxLineLength = 88 },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        black = { enabled = true },
        isort = { enabled = true },
        mypy = { enabled = true },
        pylsp_rope = { enabled = true },
      },
    },
  },
})

-- Configurações específicas para TypeScript/JavaScript
vim.lsp.config("ts_ls", {
  settings = {
    typescript = {
      preferences = {
        includePackageJsonAutoImports = "auto",
      },
    },
    javascript = {
      preferences = {
        includePackageJsonAutoImports = "auto",
      },
    },
  },
})

-- Configurações específicas para C/C++ (clangd)
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

-- Configurações específicas para Emmet
vim.lsp.config("emmet_ls", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})

-- Configurações específicas para TailwindCSS
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})

-- Configurações específicas para JSON
vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
      },
    },
  },
})
