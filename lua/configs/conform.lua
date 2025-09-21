local options = {
  formatters_by_ft = {
    -- Lua
    lua = { "stylua" },

    -- Python
    python = { "black", "isort" },

    -- JavaScript/TypeScript/React
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },

    -- Web
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    sass = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    yml = { "prettier" },
    markdown = { "prettier" },

    -- C/C++
    c = { "clang_format" },
    cpp = { "clang_format" },

    -- Rust (handled by rustaceanvim)
    -- rust = { "rustfmt" }, -- comentado porque rustaceanvim já cuida disso

    -- Shell
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },

  -- Configurações específicas dos formatadores
  formatters = {
    black = {
      prepend_args = { "--line-length", "88" },
    },
    prettier = {
      prepend_args = {
        "--tab-width",
        "2",
        "--single-quote",
        "--trailing-comma",
        "es5",
        "--print-width",
        "100",
      },
    },
    clang_format = {
      prepend_args = {
        "--style",
        "{BasedOnStyle: llvm, IndentWidth: 4, AllowShortIfStatementsOnASingleLine: false, ColumnLimit: 100}",
      },
    },
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
  },

  -- Formatar automaticamente ao salvar
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },

  -- Configurar formatação manual
  format_after_save = {
    lsp_fallback = true,
  },

  -- Log level para debug
  log_level = vim.log.levels.ERROR,

  -- Notificar quando não há formatador disponível
  notify_on_error = true,
}

return options
