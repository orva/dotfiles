(local {: dep-spec} (require :util))

(fn init []
  (set vim.o.termguicolors true))

(fn config []
  (let [catppuccin (require :catppuccin)] ; flavours from dark->light: mocha macchiato frappe latte
    (catppuccin.setup {:background {:light :latte :dark :frappe}
                       :integrations {:neotree true}})
    (set vim.o.background :light)
    (vim.cmd.colorscheme :catppuccin)))

(dep-spec :catppuccin/nvim {:name :colors :priority 1000 : init : config})
