(local {: dep-spec} (require :util))

(fn config []
  (let [loader (require :luasnip.loaders.from_vscode)]
    (loader:lazy_load)))

(dep-spec :L3MON4D3/LuaSnip {:name :snippets
                             :version :v2.*
                             :dependencies [:rafamadriz/friendly-snippets]
                             :build "make install_jsregexp"
                             : config})
