-- [nfnl] Compiled from lua/plugins/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local telescope = require("telescope")
  local commands = require("telescope.builtin")
  telescope.setup({defaults = {layout_strategy = "vertical"}})
  telescope.load_extension("fzy_native")
  vim.keymap.set("n", "<C-b>", commands.buffers)
  vim.keymap.set("n", "<C-p>", commands.find_files)
  vim.keymap.set("n", "<leader>fg", commands.live_grep)
  vim.keymap.set("n", "<leader>fh", commands.help_tags)
  vim.keymap.set("n", "<leader>fc", commands.commands)
  return vim.keymap.set("n", "<leader>fd", commands.diagnostics)
end
return dep_spec("nvim-telescope/telescope.nvim", {name = "telescope", tag = "0.1.4", dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim"}, config = config})
