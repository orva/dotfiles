(local {: dep-spec } (require :util))

(fn config []
  (let [command (require :neo-tree.command)]
    (command.execute {:action :show})
    (vim.keymap.set :n "<leader>T" #(command.execute {:action :focus :toggle true}))
    (vim.keymap.set :n "<leader>tt" #(command.execute {:action :focus}))
    (vim.keymap.set :n "<leader>tf" #(command.execute {:reveal true}))))

(dep-spec "nvim-neo-tree/neo-tree.nvim"
          {:branch "v3.x"
	   :dependencies ["nvim-lua/plenary.nvim"
			  "nvim-tree/nvim-web-devicons"
			  "MunifTanjim/nui.nvim"]
	   : config})
