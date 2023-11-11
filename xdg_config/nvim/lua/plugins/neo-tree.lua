-- [nfnl] Compiled from lua/plugins/neo-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local command = require("neo-tree.command")
  command.execute({action = "focus", toggle = true})
  local function _2_()
    return command.execute({action = "focus", toggle = true})
  end
  vim.keymap.set("n", "<leader>T", _2_)
  local function _3_()
    return command.execute({reveal = true})
  end
  return vim.keymap.set("n", "<leader>tf", _3_)
end
return dep_spec("nvim-neo-tree/neo-tree.nvim", {branch = "v3.x", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, config = config})
