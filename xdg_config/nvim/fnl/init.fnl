(module init
  {autoload {: plugins
             telescope telescope.builtin
             tree-api nvim-tree.api
             nvim aniseed.nvim}})

(plugins.setup)

(set nvim.g.loaded_netrw 1)
(set nvim.g.loaded_netrwPlugin 1)

(set nvim.o.termguicolors true)
(vim.cmd.colorscheme "gruvbox")
(set nvim.o.background "dark")

(set nvim.g.mapleader "\\")
(set nvim.g.maplocalleader "\\")

(vim.keymap.set "n" "<leader>b" telescope.buffers)
(vim.keymap.set "n" "<leader>ff" telescope.find_files)
(vim.keymap.set "n" "<leader>fg" telescope.live_grep)
(vim.keymap.set "n" "<leader>fh" telescope.help_tags)
(vim.keymap.set "n" "<leader>T" tree-api.tree.toggle)
(vim.keymap.set "n" "<leader>t" tree-api.tree.focus)

