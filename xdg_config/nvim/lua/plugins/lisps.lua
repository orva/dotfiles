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
local function find_fennel()
  local _let_3_ = vim.fs.find(fennel_project_3f, {upward = true, stop = vim.fn.getcwd(), path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))})
  local project_root = _let_3_[1]
  return (vim.fs.find("fennel", {path = project_root}))[1]
end
local function use_project_fennel()
  local local_fennel = find_fennel()
  if local_fennel then
    vim.cmd.ConjureFnlStop()
    vim.g["conjure#client#fennel#stdio#command"] = local_fennel
    return vim.cmd.ConjureFnlStart()
  else
    return vim.notify("Could not find local fennel, continuing with global", vim.log.levels.WARN)
  end
end
local function use_love_fennel()
  vim.cmd.ConjureFnlStop()
  vim.g["conjure#client#fennel#stdio#command"] = "love ."
  return vim.cmd.ConjureFnlStart()
end
local function _5_()
  vim.g["conjure#filetypes"] = {"clojure", "fennel", "janet", "hy", "julia", "racket", "scheme", "lua", "lisp", "python", "sql"}
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.stdio"
  vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
  vim.g["conjure#client#guile#socket#pipename"] = ".guile-repl.socket"
  vim.api.nvim_create_user_command("FnlUseProject", use_project_fennel, {})
  return vim.api.nvim_create_user_command("FnlUseLove", use_love_fennel, {})
end
local function _6_()
  vim.g.sexp_filetypes = "clojure,scheme,lisp,timl,fennel,janet"
  return nil
end
return {dep_spec("Olical/conjure", {init = _5_}), dep_spec("tpope/vim-sexp-mappings-for-regular-people", {dependencies = {"guns/vim-sexp", "tpope/vim-repeat"}, init = _6_}), dep_spec("tpope/vim-surround")}
