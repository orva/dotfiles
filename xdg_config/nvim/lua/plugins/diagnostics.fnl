(local {: dep-spec } (require :util))

(fn config []
  (let [ls (require :null-ls)
        trouble (require :trouble)]
    (ls.setup {:sources [(. ls :builtins :diagnostics :eslint)
                         (. ls :builtins :diagnostics :clj_kondo)
                         (. ls :builtins :formatting :biome)
                         (. ls :builtins :formatting :zprint)
                         (. ls :builtins :formatting :rustfmt)]})

        (vim.keymap.set :n "<leader>xx" trouble.toggle)
        (vim.keymap.set :n "<leader>xw" #(trouble.toggle :workspace_diagnostics))
        (vim.keymap.set :n "<leader>xd" #(trouble.toggle :document_diagnostics))
        (vim.keymap.set :n "<leader>xq" #(trouble.toggle :quickfix))
        (vim.keymap.set :n "<leader>xl" #(trouble.toggle :locklist))
        (vim.keymap.set :n "<leader>xr" #(trouble.toggle :lsp_references))))

; null-ls renamed to none-ls
(dep-spec "nvimtools/none-ls.nvim"
          {:dependencies ["nvim-lua/plenary.nvim"
                          "folke/trouble.nvim"
                          "nvim-tree/nvim-web-devicons"]
           : config})
