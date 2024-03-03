(local {: dep-spec} (require :util))

(fn config []
  (let [neo-tree (require :neo-tree)
        command (require :neo-tree.command)]
    (vim.keymap.set :n :<leader>tt
                    #(command.execute {:action :focus :toggle true}))
    (vim.keymap.set :n :<leader>tf #(command.execute {:reveal true}))
    (neo-tree.setup {:close_if_last_window true
                     :filesystem {:use_libuv_file_watcher true}})))

(dep-spec :nvim-neo-tree/neo-tree.nvim
          {:branch :v3.x
           :dependencies [:nvim-lua/plenary.nvim
                          :nvim-tree/nvim-web-devicons
                          :MunifTanjim/nui.nvim]
           : config})
