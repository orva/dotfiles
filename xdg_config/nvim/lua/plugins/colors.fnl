(local {: dep-spec} (require :util))

(fn init []
  (set vim.o.termguicolors true))

(fn config []
  (let [catppuccin (require :catppuccin)]
    ; flavours from dark->light: mocha macchiato frappe latte
    (catppuccin.setup {:background {:light :latte
                                    :dark :frappe}
		       :integrations {:neotree true}})
    (set vim.o.background :dark)
    (vim.cmd.colorscheme "catppuccin")))

(dep-spec "catppuccin/nvim"
	  {:name catppuccin
	   :priority 1000
	   : init
	   : config})
