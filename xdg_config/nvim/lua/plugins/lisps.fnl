(local {: dep-spec } (require :util))

[(dep-spec "Olical/conjure")
 (dep-spec "guns/vim-sexp"
           {:dependencies ["tpope/vim-sexp-mappings-for-regular-people"
                           "tpope/vim-repeat"]
            :init #(set vim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")})
 (dep-spec "tpope/vim-surround")]
