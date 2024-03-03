-- [nfnl] Compiled from lua/plugins/neo-tree.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local neo_tree = require("neo-tree")
  local command = require("neo-tree.command")
  local function _2_()
    return command.execute({action = "focus", toggle = true})
  end
  vim.keymap.set("n", "<leader>tt", _2_)
  local function _3_()
    return command.execute({reveal = true})
  end
  vim.keymap.set("n", "<leader>tf", _3_)
  return neo_tree.setup({close_if_last_window = true, filesystem = {use_libuv_file_watcher = true}})
end
return dep_spec("nvim-neo-tree/neo-tree.nvim", {branch = "v3.x", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}, config = config})
