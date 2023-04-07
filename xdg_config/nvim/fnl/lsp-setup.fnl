(module lsp-setup
  {autoload {: lspconfig
             : luasnip
             : cmp
             : cmp_nvim_lsp
             a aniseed.core
             nvim aniseed.nvim}})

(lspconfig.clangd.setup {})
(lspconfig.pyright.setup {})
(lspconfig.tsserver.setup {})
(lspconfig.rust_analyzer.setup {})

(defn- lsp-autocmd [ev]
  (let [opts {:buffer ev.buf}]
    (vim.keymap.set :n "gD" vim.lsp.buf.declaration opts)
    (vim.keymap.set :n "gd" vim.lsp.buf.definition opts)
    (vim.keymap.set :n "K" vim.lsp.buf.hover opts)
    (vim.keymap.set :n "gi" vim.lsp.buf.implementation opts)
    (vim.keymap.set :n "gr" vim.lsp.buf.remove_workspace_folder opts)
    (vim.keymap.set :n "<C-k>" vim.lsp.buf.signature_help opts)
    (vim.keymap.set :n "<space>D" vim.lsp.buf.type_definition opts)
    (vim.keymap.set :n "<space>rn" vim.lsp.buf.rename opts)
    (vim.keymap.set :n "<space>ca" vim.lsp.buf.code_action opts)
    (vim.keymap.set :n "<space>f" (fn [] (vim.lsp.buf.format {:async true})) opts)))

(nvim.create_autocmd
  :LspAttach
  {:group (nvim.create_augroup :UserLspConfig {})
   :callback lsp-autocmd})


(def- capabilities (cmp_nvim_lsp.default_capabilities))
(a.run!
  (fn [lsp]
    (let [setup (. lspconfig lsp :setup)]
      (setup {:capabilities capabilities})))
  ["clangd" "rust_analyzer" "pyright" "tsserver"])

(cmp.setup
  {:snippet {:expand (fn [args]
                       (luasnip.lsp_expand (. args :body)))}
   :mapping (cmp.mapping.preset.insert
              {"<C-u>" (cmp.mapping.scroll_docs -4)
               "<C-d>" (cmp.mapping.scroll_docs -4)
               "<C-Space>" (cmp.mapping.complete)
               "<CR>" (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                            :select true})
               "<Tab>" (cmp.mapping
                         (fn [fallback]
                           (if 
                             (cmp.visible)
                             (cmp.select_next_item)
                             (luasnip.expand_or_jumpable)
                             (luasnip.expand_or_jump)
                             (fallback)))
                         [:i :s])
               "<S-Tab>" (cmp.mapping
                           (fn [fallback]
                             (if
                               (cmp.visible)
                               (cmp.select_prev_item)
                               (luasnip.jumpable -1)
                               (luasnip.jump -1)
                               (fallback)))
                           [:i :s])})
   :sources [{:name :nvim_lsp}
             {:name :luasnip}]})
