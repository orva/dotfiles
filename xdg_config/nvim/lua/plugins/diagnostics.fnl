(local {: dep-spec } (require :util))

(fn config []
  (let [ls (require :null-ls)]
    (ls.setup {:sources [(. ls :builtins :diagnostics :eslint)
                         (. ls :builtins :diagnostics :clj_kondo)
                         (. ls :builtins :formatting :prettier)
                         (. ls :builtins :formatting :zprint)
                         (. ls :builtins :formatting :rustfmt)]})))

; null-ls renamed to none-ls
(dep-spec "nvimtools/none-ls.nvim"
          {:dependencies ["nvim-lua/plenary.nvim"]
           : config})
