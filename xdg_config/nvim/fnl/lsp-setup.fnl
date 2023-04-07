(module lsp-setup
  {autoload {nvim aniseed.nvim}})

(defn- lsp-autocmd [ev]
  (let [opts {:buffer ev.buf}]
    (vim.keymap.set :n "gD" vim.lsp.buf.declaration opts)
    (vim.keymap.set :n "gd" vim.lsp.buf.definition opts)
    (vim.keymap.set :n "K" vim.lsp.buf.hover opts)
    (vim.keymap.set :n "gi" vim.lsp.buf.implementation opts)
    (vim.keymap.set :n "gr" vim.lsp.buf.references opts)
    (vim.keymap.set :n "<C-k>" vim.lsp.buf.signature_help opts)
    (vim.keymap.set :n "<space>D" vim.lsp.buf.type_definition opts)
    (vim.keymap.set :n "<space>rn" vim.lsp.buf.rename opts)
    (vim.keymap.set :n "<space>ca" vim.lsp.buf.code_action opts)
    (vim.keymap.set :n "<space>f" (fn [] (vim.lsp.buf.format {:async true})) opts)))

(nvim.create_autocmd
  :LspAttach
  {:group (nvim.create_augroup :UserLspConfig {})
   :callback lsp-autocmd})
