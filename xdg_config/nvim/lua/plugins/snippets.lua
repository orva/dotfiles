-- [nfnl] Compiled from lua/plugins/snippets.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local loader = require("luasnip.loaders.from_vscode")
  return loader:lazy_load()
end
return dep_spec("L3MON4D3/LuaSnip", {name = "snippets", version = "v2.*", dependencies = {"rafamadriz/friendly-snippets"}, build = "make install_jsregexp", config = config})
