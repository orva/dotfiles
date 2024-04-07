-- [nfnl] Compiled from lua/plugins/lisps.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function _2_()
  vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "hy", "julia", "racket", "scheme", "lua", "lisp", "python", "sql"}
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  return nil
end
local function _3_()
  vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
  return nil
end
return {dep_spec("Olical/conjure", {init = _2_}), dep_spec("tpope/vim-sexp-mappings-for-regular-people", {dependencies = {"guns/vim-sexp", "tpope/vim-repeat"}, init = _3_}), dep_spec("tpope/vim-surround")}
