-- [nfnl] Compiled from lua/plugins/colors.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function init()
  vim.o.termguicolors = true
  return nil
end
local function config()
  local catppuccin = require("catppuccin")
  catppuccin.setup({background = {light = "latte", dark = "frappe"}, integrations = {neotree = true}})
  vim.o.background = "dark"
  return vim.cmd.colorscheme("catppuccin")
end
return dep_spec("catppuccin/nvim", {name = catppuccin, priority = 1000, init = init, config = config})
