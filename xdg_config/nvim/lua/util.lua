-- [nfnl] Compiled from lua/util.fnl by https://github.com/Olical/nfnl, do not edit.
local core = require("nfnl.core")
local function dep_spec(name, opts_3f)
  local opts = (opts_3f or {})
  return core.assoc(opts, 1, name)
end
return {["dep-spec"] = dep_spec}
