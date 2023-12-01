-- [nfnl] Compiled from lua/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local _let_2_ = require("nvim-treesitter.configs")
  local setup = _let_2_["setup"]
  return setup({ensure_installed = {"c", "cpp", "css", "lua", "svelte", "javascript", "typescript", "rust", "fennel", "clojure", "markdown", "markdown_inline"}, highlight = {enable = true}})
end
local function build()
  local _let_3_ = require("nvim-treesitter.install")
  local update = _let_3_["update"]
  return update({with_sync = true})
end
return dep_spec("nvim-treesitter/nvim-treesitter", {build = build, config = config})
