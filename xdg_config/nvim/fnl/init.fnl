(module init
  {require [plugins lsp-setup]
   autoload {telescope telescope.builtin
             tree-api nvim-tree.api
             nvim aniseed.nvim}})

(set nvim.g.loaded_netrw 1)
(set nvim.g.loaded_netrwPlugin 1)
(set nvim.o.termguicolors true)
(set nvim.o.background "dark")
(set nvim.o.relativenumber true)
(set nvim.o.timeoutlen 500)
(set nvim.o.scrolloff 15)

(vim.cmd.colorscheme "gruvbox")

(set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")

(set nvim.g.mapleader "\\")
(set nvim.g.maplocalleader "\\")
(vim.keymap.set :n "<leader>ch" vim.cmd.nohlsearch)
(vim.keymap.set :n "<C-b>" telescope.buffers)
(vim.keymap.set :n "<C-p>" telescope.find_files)
(vim.keymap.set :n "<leader>fg" telescope.live_grep)
(vim.keymap.set :n "<leader>fh" telescope.help_tags)
(vim.keymap.set :n "<leader>fc" telescope.commands)
(vim.keymap.set :n "<leader>fd" telescope.diagnostics)
(vim.keymap.set :n "<leader>T" tree-api.tree.toggle)
(vim.keymap.set :n "<leader>t" tree-api.tree.focus)

