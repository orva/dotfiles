-- [nfnl] Compiled from lua/plugins/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local ls = require("null-ls")
  local trouble = require("trouble")
  ls.setup({sources = {ls.builtins.diagnostics.clj_kondo, ls.builtins.formatting.biome, ls.builtins.formatting.zprint, ls.builtins.formatting.fnlfmt}})
  vim.keymap.set("n", "<leader>xx", trouble.toggle)
  local function _2_()
    return trouble.toggle("workspace_diagnostics")
  end
  vim.keymap.set("n", "<leader>xw", _2_)
  local function _3_()
    return trouble.toggle("document_diagnostics")
  end
  vim.keymap.set("n", "<leader>xd", _3_)
  local function _4_()
    return trouble.toggle("quickfix")
  end
  vim.keymap.set("n", "<leader>xq", _4_)
  local function _5_()
    return trouble.toggle("locklist")
  end
  vim.keymap.set("n", "<leader>xl", _5_)
  local function _6_()
    return trouble.toggle("lsp_references")
  end
  return vim.keymap.set("n", "<leader>xr", _6_)
end
return dep_spec("nvimtools/none-ls.nvim", {dependencies = {"nvim-lua/plenary.nvim", "folke/trouble.nvim", "nvim-tree/nvim-web-devicons"}, config = config})
