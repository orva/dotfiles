(module plugins
  {autoload {a      aniseed.core
             nvim   aniseed.nvim
             packer packer}})

(defn- run-treesitter-update []
  (let [ts-install (require "nvim-treesitter.install")
        ts-update  (ts-install:update { :with_sync true })]
    (ts-update)))

(defn setup []
  (packer.startup
    (fn [packer-use]
      ;; Fennel doesn't approve "mixed mode" table literals with positional and
      ;; keyword values. Sadly this is what packer expects as parameters, so
      ;; we have this little helper.
      (fn use [name maybe-opts]
        (let [opts (if (= nil maybe-opts) {} maybe-opts)]
          (packer-use (a.assoc opts 1 name))))

      (use "wbthomason/packer.nvim")
      (use "Olical/aniseed")
      (use "Olical/conjure")
      (use "nvim-treesitter/nvim-treesitter"
           {:run run-treesitter-update})
      (use "morhetz/gruvbox")

      (when (not= nil nvim.g.packer_sync_required)
        (packer.sync)))))

