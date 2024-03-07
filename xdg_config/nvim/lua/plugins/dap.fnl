(local {: dep-spec} (require :util))

(fn config []
  (let [dap (require :dap)
        dapui (require :dapui)]
    (dapui.setup)
    (set dap.listeners.before.attach.dapui_config #(dapui.open))
    (set dap.listeners.before.launch.dapui_config #(dapui.open))
    (set dap.listeners.before.event_terminated.dapui_config #(dapui.close))
    (set dap.listeners.before.event_exited.dapui_config #(dapui.close))
    (vim.keymap.set :n :<F5> #(dap.continue))
    (vim.keymap.set :n :<F10> #(dap.step_over))
    (vim.keymap.set :n :<F11> #(dap.step_into))
    (vim.keymap.set :n :<F12> #(dap.step_out))
    (vim.keymap.set :n :<Leader>b #(dap.toggle_breakpoint))
    (vim.keymap.set :n :<Leader>dl #(dap.run_last))
    (set dap.adapters.gdb {:type :executable :command :gdb :args [:-i :dap]})
    (set dap.configurations.rust
         [{:name "Debug rust"
           :type :gdb
           :request :launch
           :program #(vim.fn.input "Path to executable: "
                                   (.. (vim.fn.getcwd) :/target/debug/) :file)
           :cwd "${workspaceFolder}"
           :stopAtBeginningOfMainSubprogram false}])))

(dep-spec :rcarriga/nvim-dap-ui {:name :dap
                                 :dependencies [:mfussenegger/nvim-dap]
                                 : config})
