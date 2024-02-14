-- [nfnl] Compiled from lua/plugins/quality-of-life.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function guess_indent_setup()
  local guess_indent = require("guess-indent")
  return guess_indent.setup()
end
return {dep_spec("tpope/vim-sensible"), dep_spec("NMAC427/guess-indent.nvim", {config = guess_indent_setup})}
