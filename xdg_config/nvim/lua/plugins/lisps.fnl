(local {: dep-spec} (require :util))

(local project-markers [".*\\.rockspec" :lua_modules "\\.git"])
(fn fennel-project? [name _path]
  (not (vim.tbl_isempty (vim.tbl_filter #(name:match $) project-markers))))

(fn find-fennel []
  (let [[project-root] (vim.fs.find fennel-project?
                                    {:upward true
                                     :stop (vim.fn.getcwd)
                                     :path (-> (vim.api.nvim_buf_get_name 0)
                                               vim.fs.dirname)})]
    (. (vim.fs.find :fennel {:path project-root}) 1)))

(fn use-project-fennel []
  (let [local-fennel (find-fennel)]
    (if local-fennel
        (do
          (vim.cmd.ConjureFnlStop)
          (set vim.g.conjure#client#fennel#stdio#command local-fennel)
          (vim.cmd.ConjureFnlStart))
        (vim.notify "Could not find local fennel, continuing with global" vim.log.levels.WARN))))

(fn use-love-fennel []
  (vim.cmd.ConjureFnlStop)
  (set vim.g.conjure#client#fennel#stdio#command "love .")
  (vim.cmd.ConjureFnlStart))

[(dep-spec :Olical/conjure
           {:init (fn []
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
                         :conjure.client.fennel.stdio)
                    (set vim.g.conjure#filetype#scheme
                         :conjure.client.guile.socket)
                    (set vim.g.conjure#client#guile#socket#pipename
                         :.guile-repl.socket)
                    (vim.api.nvim_create_user_command :FnlUseProject use-project-fennel {})
                    (vim.api.nvim_create_user_command :FnlUseLove use-love-fennel {}))})
 (dep-spec :tpope/vim-sexp-mappings-for-regular-people
           {:dependencies [:guns/vim-sexp :tpope/vim-repeat]
            :init #(set vim.g.sexp_filetypes
                        "clojure,scheme,lisp,timl,fennel,janet")})
 (dep-spec :tpope/vim-surround)]
