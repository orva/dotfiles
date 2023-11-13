-- [nfnl] Compiled from lua/plugins/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local ls = require("null-ls")
  return ls.setup({sources = {ls.builtins.diagnostics.eslint, ls.builtins.diagnostics.clj_kondo, ls.builtins.formatting.prettier, ls.builtins.formatting.cljstyle, ls.builtins.formatting.rustfmt}})
end
return dep_spec("nvimtools/none-ls.nvim", {dependencies = {"nvim-lua/plenary.nvim"}, config = config})
