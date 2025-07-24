require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "ts_ls", "python-lsp-server" }

vim.lsp.enable(servers)
