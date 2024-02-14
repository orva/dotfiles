(local {: dep-spec} (require :util))

(fn guess-indent-setup []
  (let [guess-indent (require :guess-indent)]
    (guess-indent.setup)))

[(dep-spec :tpope/vim-sensible)
 (dep-spec :NMAC427/guess-indent.nvim {:config guess-indent-setup})]
