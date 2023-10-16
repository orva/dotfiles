(module plugins
  {autoload {a      aniseed.core
             nvim   aniseed.nvim
             packer packer}})

; NOTE: All functions given to packer hooks are serialized for lazy loading
; purposes. This means that they need to be standalone, so they cannot
; capture anything from their environment.

(defn- run-treesitter-update []
  (let [ts-install (require :nvim-treesitter.install)
        ts-update  (ts-install.update {:with_sync true})]
    (ts-update)))

(defn- treesitter-config []
  (let [ts-config (require :nvim-treesitter.configs)]
    (ts-config.setup
      {:ensure_installed ["c" "cpp" "css" "lua" "svelte" "javascript" "typescript"
                          "rust" "fennel" "clojure"]
       :highlight {:enable true}})))

(defn- lualine-config []
  (let [lualine (require :lualine)]
    (lualine.setup {:options {:theme :gruvbox-material}})))

(defn- nvim-tree-config []
  (let [tree (require :nvim-tree)]
    (tree.setup)))

(defn- telescope-config []
  (let [telescope (require :telescope)]
    (telescope.setup
      {:defaults {:layout_strategy :vertical}})
    (telescope.load_extension :fzy_native)))

(defn lsp-config []
  (let [a (require :aniseed.core)
        cmp (require :cmp)
        luasnip (require :luasnip)
        lspconfig (require :lspconfig)
        cmp_nvim_lsp (require :cmp_nvim_lsp)
        capabilities (cmp_nvim_lsp.default_capabilities)]

    ; setup some lsp servers and set autocomplete capabilities
    (lspconfig.clangd.setup {: capabilities})
    (lspconfig.pyright.setup {: capabilities})
    (lspconfig.rust_analyzer.setup {: capabilities})

    ; These require global language servers:
    ; npm install -g typescript typescript-language-server vscode-langservers-extracted svelte-language-server
    (lspconfig.tsserver.setup {: capabilities})
    (lspconfig.eslint.setup {: capabilities})
    (lspconfig.svelte.setup {: capabilities})

    (cmp.setup
      {:snippet {:expand (fn [args] (luasnip.lsp_expand (. args :body)))}
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
                 {:name :luasnip}]})))

(packer.startup
  (fn [packer-use]
    ; Fennel doesn't approve "mixed mode" table literals with both positional
    ; and keyword values. Sadly this is what packer expects as parameters, so
    ; we have this little helper.
    (fn use [name maybe-opts]
      (let [opts (if (not= nil maybe-opts) maybe-opts {})]
        (packer-use (a.assoc opts 1 name))))

    (use "wbthomason/packer.nvim")
    (use "sainnhe/gruvbox-material")
    (use "nvim-lualine/lualine.nvim"
         {:requires ["nvim-tree/nvim-web-devicons"]
          :config lualine-config})
    (use "Olical/aniseed")
    (use "Olical/conjure")
    (use "guns/vim-sexp"
         {:requires ["tpope/vim-sexp-mappings-for-regular-people"]})
    (use "nvim-treesitter/nvim-treesitter"
         {:run run-treesitter-update
          :config treesitter-config})
    (use "tpope/vim-repeat")
    (use "tpope/vim-surround")
    (use "nvim-tree/nvim-tree.lua"
         {:requires ["nvim-tree/nvim-web-devicons"]
          :config nvim-tree-config})
    (use "nvim-telescope/telescope.nvim"
         {:tag "0.1.3"
          :requires ["nvim-lua/plenary.nvim"
                     "nvim-telescope/telescope-fzy-native.nvim"]
          :config telescope-config})
    (use "neovim/nvim-lspconfig"
         {:requires ["hrsh7th/nvim-cmp"
                     "hrsh7th/cmp-nvim-lsp"
                     "saadparwaiz1/cmp_luasnip"
                     "L3MON4D3/LuaSnip"]
          :config lsp-config})
    (when (not= nil nvim.g.packer_sync_required)
      (packer.sync))))

