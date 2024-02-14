(local {: dep-spec} (require :util))

(fn config []
  (let [lualine (require :lualine)]
    (lualine.setup {:options {:theme :catppuccin}})))

(dep-spec :nvim-lualine/lualine.nvim
          {:dependencies [:nvim-tree/nvim-web-devicons] : config})
