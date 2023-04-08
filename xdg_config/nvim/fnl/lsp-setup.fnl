(module lsp-setup
  {autoload {nvim aniseed.nvim
             telescope telescope.builtin}})

(defn- lsp-autocmd [ev]
  (let [opts {:buffer ev.buf}]
    (vim.keymap.set :n "K" vim.lsp.buf.hover opts)
    (vim.keymap.set :n "gD" telescope.lsp_type_definitions opts)
    (vim.keymap.set :n "gd" telescope.lsp_definitions opts)
    (vim.keymap.set :n "gi" telescope.lsp_implementations opts)
    (vim.keymap.set :n "gr" telescope.lsp_references opts)
    (vim.keymap.set :n "<C-k>" vim.lsp.buf.signature_help opts)
    (vim.keymap.set :n "<space>D" vim.lsp.buf.type_definition opts)
    (vim.keymap.set :n "<space>rn" vim.lsp.buf.rename opts)
    (vim.keymap.set :n "<space>ca" vim.lsp.buf.code_action opts)
    (vim.keymap.set :n "<space>f" (fn [] (vim.lsp.buf.format {:async true})) opts)))

(nvim.create_autocmd
  :LspAttach
  {:group (nvim.create_augroup :UserLspConfig {})
   :callback lsp-autocmd})
