local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- We need to set some things before plugins are loaded for them to register these
-- options
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Require all plugins (including neovim fennel setup with nfnl) and run our own
-- startup code from fennel land
require("lazy").setup("plugins")
require("startup")
