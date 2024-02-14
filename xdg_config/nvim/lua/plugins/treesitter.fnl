(local {: dep-spec} (require :util))

(fn config []
  (let [{: setup} (require :nvim-treesitter.configs)]
    (setup {:ensure_installed [:c
                               :cpp
                               :css
                               :lua
                               :svelte
                               :javascript
                               :typescript
                               :rust
                               :fennel
                               :clojure
                               :markdown
                               :markdown_inline]
            :highlight {:enable true}})))

(fn build []
  (let [{: update} (require :nvim-treesitter.install)]
    (update {:with_sync true})))

(dep-spec :nvim-treesitter/nvim-treesitter {: build : config})
