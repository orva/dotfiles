(module init
  {autoload {: plugins
             nvim aniseed.nvim}})

(plugins.setup)

(set nvim.o.termguicolors true)
(vim.cmd.colorscheme "gruvbox")
(set nvim.o.background "dark")

(set nvim.g.mapleader ",")
(set nvim.g.maplocalleader ",")
