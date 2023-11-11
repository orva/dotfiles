-- [nfnl] Compiled from lua/util.fnl by https://github.com/Olical/nfnl, do not edit.
local core = require("nfnl.core")
local function dep_spec(name, maybe_opts)
  local opts
  if (nil ~= maybe_opts) then
    opts = maybe_opts
  else
    opts = {}
  end
  return core.assoc(opts, 1, name)
end
return {["dep-spec"] = dep_spec}
