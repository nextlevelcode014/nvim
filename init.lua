vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Enable true color support
vim.cmd[[ set termguicolors ]]

-- Set the transparency for the background
vim.cmd[[ hi Normal guibg=NONE ctermbg=NONE ]]
vim.cmd[[ hi SignColumn guibg=NONE ctermbg=NONE ]]
vim.cmd[[ hi VertSplit guibg=NONE ctermbg=NONE ]]
vim.cmd[[ hi StatusLine guibg=NONE ctermbg=NONE ]]
vim.cmd[[ hi TabLine guibg=NONE ctermbg=NONE ]]
vim.cmd[[ hi EndOfBuffer guibg=NONE ctermbg=NONE ]]

-- Optionally, set transparency for other UI elements as needed
vim.cmd[[ hi NormalNC guibg=NONE ctermbg=NONE ]]  -- For non-current windows
vim.cmd[[ hi Pmenu guibg=NONE ctermbg=NONE ]]  -- Popup menu
vim.cmd[[ hi LineNr guibg=NONE ctermbg=NONE ]]  -- Line numbers
vim.cmd[[ hi CursorLine guibg=NONE ctermbg=NONE ]]  -- Current line highlight

-- Make floating windows transparent
vim.cmd[[ hi FloatBorder guibg=NONE ctermbg=NONE ]]
vim.cmd[[ hi FloatTitle guibg=NONE ctermbg=NONE ]]


vim.opt.tabstop = 4       -- Número de espaços que um <Tab> representa
vim.opt.shiftwidth = 4    -- Número de espaços para indentação
