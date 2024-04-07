(local {: dep-spec} (require :util))

[(dep-spec :Olical/conjure
           {:init (fn []
                    (set vim.g.conjure#filetypes
                         [:clojure :fennel :janet :hy :julia :racket :scheme :lua :lisp :python :sql])
                    (set vim.g.conjure#filetype#fennel
                         :conjure.client.fennel.stdio))})
 (dep-spec :tpope/vim-sexp-mappings-for-regular-people
           {:dependencies [:guns/vim-sexp :tpope/vim-repeat]
            :init #(set vim.g.sexp_filetypes
                        "clojure,scheme,lisp,timl,fennel,janet")})
 (dep-spec :tpope/vim-surround)]
