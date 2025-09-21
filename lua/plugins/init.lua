return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Configuração da IA
  {
    "David-Kunz/gen.nvim",
    event = "VeryLazy", -- Carregar depois que tudo estiver pronto
    config = function()
      -- Chamar a função setup que configura tudo
      require('configs.ai').setup()
    end,
    cmd = { "Gen" }, -- Também disponibilizar o comando Gen
  },

-- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
