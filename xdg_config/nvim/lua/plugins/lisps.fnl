(local {: dep-spec} (require :util))

[(dep-spec :Olical/conjure {:config #(set vim.g#conjure#filetypes
                                          [:clojure
                                           :fennel
                                           :janet
                                           :hy
                                           :julia
                                           :racket
                                           :scheme
                                           :lua
                                           :lisp
                                           :python
                                           :sql])})
 (dep-spec :guns/vim-sexp
           {:dependencies [:tpope/vim-sexp-mappings-for-regular-people
                           :tpope/vim-repeat]
            :config #(set vim.g.sexp_filetypes
                          "clojure,scheme,lisp,timl,fennel,janet")})
 (dep-spec :tpope/vim-surround)]
