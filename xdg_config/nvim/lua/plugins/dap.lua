-- [nfnl] Compiled from lua/plugins/dap.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function config()
  local dap = require("dap")
  local dapui = require("dapui")
  dapui.setup()
  local function _2_()
    return dapui.open()
  end
  dap.listeners.before.attach.dapui_config = _2_
  local function _3_()
    return dapui.open()
  end
  dap.listeners.before.launch.dapui_config = _3_
  local function _4_()
    return dapui.close()
  end
  dap.listeners.before.event_terminated.dapui_config = _4_
  local function _5_()
    return dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = _5_
  local function _6_()
    return dap.continue()
  end
  vim.keymap.set("n", "<F5>", _6_)
  local function _7_()
    return dap.step_over()
  end
  vim.keymap.set("n", "<F10>", _7_)
  local function _8_()
    return dap.step_into()
  end
  vim.keymap.set("n", "<F11>", _8_)
  local function _9_()
    return dap.step_out()
  end
  vim.keymap.set("n", "<F12>", _9_)
  local function _10_()
    return dap.toggle_breakpoint()
  end
  vim.keymap.set("n", "<Leader>b", _10_)
  local function _11_()
    return dap.run_last()
  end
  vim.keymap.set("n", "<Leader>dl", _11_)
  dap.adapters.gdb = {type = "executable", command = "gdb", args = {"-i", "dap"}}
  local function _12_()
    return vim.fn.input("Path to executable: ", (vim.fn.getcwd() .. "/target/debug/"), "file")
  end
  dap.configurations.rust = {{name = "Debug rust", type = "gdb", request = "launch", program = _12_, cwd = "${workspaceFolder}", stopAtBeginningOfMainSubprogram = false}}
  return nil
end
return dep_spec("rcarriga/nvim-dap-ui", {name = "dap", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}, config = config})
