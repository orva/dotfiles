-- [nfnl] Compiled from lua/plugins/lualine.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local lualine = require("lualine")
  return lualine.setup({options = {theme = "catppuccin"}})
end
return dep_spec("nvim-lualine/lualine.nvim", {requires = {"nvim-tree/nvim-web-devicons"}, config = config})
