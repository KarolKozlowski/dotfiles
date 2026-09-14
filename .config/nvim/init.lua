-- ~/.config/nvim/init.lua

-- bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load editor options
require("config.options")

-- load view management
require("karol.views")
require("karol.window")

-- load keymaps
require("config.keymaps")

require("lazy").setup("plugins")
