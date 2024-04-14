-- [nfnl] Compiled from lua/plugins/lisps.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local project_markers = {".*\\.rockspec", "lua_modules", "\\.git"}
local function fennel_project_3f(name, _path)
  local function _2_(_241)
    return name:match(_241)
  end
  return not vim.tbl_isempty(vim.tbl_filter(_2_, project_markers))
end
local function find_local_fennel(path)
  local _let_3_ = vim.fs.find("fennel", {path = path})
  local local_fennel = _let_3_[1]
  return (local_fennel or "fennel")
end
local function find_fennel()
  local _let_4_ = vim.fs.find(fennel_project_3f, {upward = true, stop = vim.fn.getcwd(), path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))})
  local project_root = _let_4_[1]
  if project_root then
    return find_local_fennel(project_root)
  else
    return "fennel"
  end
end
local function _6_()
  vim.g["conjure#client#fennel#stdio#command"] = find_fennel()
  return nil
end
local function _7_()
  vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "hy", "julia", "racket", "scheme", "lua", "lisp", "python", "sql"}
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  return nil
end
local function _8_()
  vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
  return nil
end
return {dep_spec("Olical/conjure", {config = _6_, init = _7_}), dep_spec("tpope/vim-sexp-mappings-for-regular-people", {dependencies = {"guns/vim-sexp", "tpope/vim-repeat"}, init = _8_}), dep_spec("tpope/vim-surround")}
