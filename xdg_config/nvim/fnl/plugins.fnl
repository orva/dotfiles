(module plugins
  {autoload {a      aniseed.core
             nvim   aniseed.nvim
             packer packer}})

(defn- run-treesitter-update []
  (let [ts-install (require "nvim-treesitter.install")
        ts-update  (ts-install.update { :with_sync true })]
    (ts-update)))

(defn- run-nvim-tree-config []
  (let [tree (require "nvim-tree")]
    (tree.setup)))

(defn- telescope-config []
  (let [telescope (require "telescope")]
    (telescope.setup)
    (telescope.load_extension "fzy_native")))

(packer.startup
  (fn [packer-use]
    ; Fennel doesn't approve "mixed mode" table literals with positional and
    ; keyword values. Sadly this is what packer expects as parameters, so
    ; we have this little helper.
    (fn use [name maybe-opts]
      (let [opts (if (= nil maybe-opts) {} maybe-opts)]
        (packer-use (a.assoc opts 1 name))))

    (use "wbthomason/packer.nvim")
    (use "Olical/aniseed")
    (use "Olical/conjure")
    (use "guns/vim-sexp"
         {:requires ["tpope/vim-sexp-mappings-for-regular-people"]})
    (use "nvim-treesitter/nvim-treesitter"
         {:run run-treesitter-update})
    (use "tpope/vim-repeat")
    (use "tpope/vim-surround")
    (use "morhetz/gruvbox")
    (use "nvim-tree/nvim-tree.lua"
         {:requires ["nvim-tree/nvim-web-devicons"]
          :config run-nvim-tree-config})
    (use "nvim-telescope/telescope.nvim"
         {:tag "0.1.1"
          :requires ["nvim-lua/plenary.nvim"
                     "nvim-telescope/telescope-fzy-native.nvim"]
          :config telescope-config})
    (use "neovim/nvim-lspconfig"
         {:requires ["hrsh7th/nvim-cmp"
                     "hrsh7th/cmp-nvim-lsp"
                     "saadparwaiz1/cmp_luasnip"
                     "L3MON4D3/LuaSnip"]})
    (when (not= nil nvim.g.packer_sync_required)
      (packer.sync))))

