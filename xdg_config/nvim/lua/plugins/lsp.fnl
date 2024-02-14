(local {: dep-spec} (require :util))

(fn vcs-root-dir [lsp-utils]
  (lsp-utils.root_pattern :.jj :.git))

(fn marksman-root-dir [lsp-utils]
  (let [vcs-match (vcs-root-dir lsp-utils)
        config-match (lsp-utils.root_pattern :.marksman.toml)]
    (fn [fname]
      (or (config-match fname) (vcs-match fname)))))

(fn lsp-autocmd [ev]
  (let [telescope (require :telescope.builtin)
        opts {:buffer ev.buf}]
    (vim.keymap.set :n :K vim.lsp.buf.hover opts)
    (vim.keymap.set :n :gD telescope.lsp_type_definitions opts)
    (vim.keymap.set :n :gd telescope.lsp_definitions opts)
    (vim.keymap.set :n :gi telescope.lsp_implementations opts)
    (vim.keymap.set :n :gr telescope.lsp_references opts)
    (vim.keymap.set :n :<C-k> vim.lsp.buf.signature_help opts)
    (vim.keymap.set :n :<space>D vim.lsp.buf.type_definition opts)
    (vim.keymap.set :n :<space>rn vim.lsp.buf.rename opts)
    (vim.keymap.set :n :<space>ca vim.lsp.buf.code_action opts)
    (vim.keymap.set :n :<space>f #(vim.lsp.buf.format {:async true}) opts)))

(fn config []
  (let [mason (require :mason)
        mason-lspconfig (require :mason-lspconfig)
        lspconfig (require :lspconfig)
        lsp-utils (require :lspconfig.util)
        cmp (require :cmp)
        luasnip (require :luasnip)
        cmp-nvim-lsp (require :cmp_nvim_lsp)
        capabilities (cmp-nvim-lsp.default_capabilities)]
    (mason.setup) ; setup some lsp servers and set autocomplete capabilities
    (mason-lspconfig.setup {:ensure_installed [:clangd
                                               :pyright
                                               :rust_analyzer
                                               :clojure_lsp
                                               :eslint
                                               :tsserver
                                               :svelte
                                               :fennel_language_server
                                               :marksman]})
    (lspconfig.clangd.setup {: capabilities})
    (lspconfig.pyright.setup {: capabilities})
    (lspconfig.rust_analyzer.setup {: capabilities})
    (lspconfig.clojure_lsp.setup {: capabilities})
    (lspconfig.tsserver.setup {: capabilities})
    (lspconfig.eslint.setup {: capabilities})
    (lspconfig.svelte.setup {: capabilities})
    (lspconfig.fennel_language_server.setup {: capabilities
                                             :single_file_support false
                                             :root_dir (vcs-root-dir lsp-utils)
                                             :settings {:fennel {:diagnostics {:globals [:vim]}}}})
    (lspconfig.marksman.setup {: capabilities
                               :single_file_support false
                               :filetypes [:markdown :md :mdx]
                               :root_dir (marksman-root-dir lsp-utils)})
    (cmp.setup {:snippet {:expand (fn [args]
                                    (luasnip.lsp_expand (. args :body)))}
                :mapping (cmp.mapping.preset.insert {:<C-u> (cmp.mapping.scroll_docs -4)
                                                     :<C-d> (cmp.mapping.scroll_docs -4)
                                                     :<C-Space> (cmp.mapping.complete)
                                                     :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                                                 :select true})
                                                     :<Tab> (cmp.mapping (fn [fallback]
                                                                           (if (cmp.visible)
                                                                               (cmp.select_next_item)
                                                                               (luasnip.expand_or_jumpable)
                                                                               (luasnip.expand_or_jump)
                                                                               (fallback)))
                                                                         [:i
                                                                          :s])
                                                     :<S-Tab> (cmp.mapping (fn [fallback]
                                                                             (if (cmp.visible)
                                                                                 (cmp.select_prev_item)
                                                                                 (luasnip.jumpable -1)
                                                                                 (luasnip.jump -1)
                                                                                 (fallback)))
                                                                           [:i
                                                                            :s])})
                :sources [{:name :nvim_lsp} {:name :luasnip}]})
    (vim.api.nvim_create_autocmd :LspAttach
                                 {:group (vim.api.nvim_create_augroup :UserLspConfig
                                                                      {})
                                  :callback lsp-autocmd})))

(dep-spec :williamboman/mason.nvim
          {:name :lsp
           :dependencies [:williamboman/mason-lspconfig.nvim
                          :neovim/nvim-lspconfig
                          :hrsh7th/nvim-cmp
                          :hrsh7th/cmp-nvim-lsp
                          :saadparwaiz1/cmp_luasnip
                          ; these setups are in different plugin
                          :snippets
                          :telescope]
           : config})
