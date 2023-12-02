-- [nfnl] Compiled from lua/startup.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
vim.o.relativenumber = true
vim.o.timeoutlen = 500
vim.o.expandtab = true
return vim.keymap.set("n", "<leader>ch", vim.cmd.nohlsearch)
