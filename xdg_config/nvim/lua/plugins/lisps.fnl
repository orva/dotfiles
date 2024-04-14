(local {: dep-spec} (require :util))

(local project-markers [".*\\.rockspec" :lua_modules "\\.git"])
(fn fennel-project? [name _path]
  (not (vim.tbl_isempty (vim.tbl_filter #(name:match $) project-markers))))

(fn find-local-fennel [path]
  (let [[local-fennel] (vim.fs.find :fennel {: path})]
    (or local-fennel :fennel)))

(fn find-fennel []
  (let [[project-root] (vim.fs.find fennel-project?
                                    {:upward true
                                     :stop (vim.fn.getcwd)
                                     :path (-> (vim.api.nvim_buf_get_name 0)
                                               vim.fs.dirname)})]
    (if project-root
        (find-local-fennel project-root) :fennel)))

[(dep-spec :Olical/conjure
           {:config (fn []
                      ;; TODO: prevent automic REPL open and add own autocmd to
                      ;;       do this this after opening fennel file.
                      (set vim.g.conjure#client#fennel#stdio#command
                           (find-fennel)))
            :init (fn []
                    (set vim.g.conjure#filetypes
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
                          :sql])
                    (set vim.g.conjure#filetype#fennel
                         :conjure.client.fennel.stdio))})
 (dep-spec :tpope/vim-sexp-mappings-for-regular-people
           {:dependencies [:guns/vim-sexp :tpope/vim-repeat]
            :init #(set vim.g.sexp_filetypes
                        "clojure,scheme,lisp,timl,fennel,janet")})
 (dep-spec :tpope/vim-surround)]
