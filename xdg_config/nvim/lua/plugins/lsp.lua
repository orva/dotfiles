-- [nfnl] Compiled from lua/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function lsp_autocmd(ev)
  local telescope = require("telescope.builtin")
  local opts = {buffer = ev.buf}
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gD", telescope.lsp_type_definitions, opts)
  vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
  vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
  vim.keymap.set("n", "gr", telescope.lsp_references, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  local function _2_()
    return vim.lsp.buf.format({async = true})
  end
  return vim.keymap.set("n", "<space>f", _2_, opts)
end
local function config()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local capabilities = cmp_nvim_lsp.default_capabilities()
  mason.setup()
  mason_lspconfig.setup({ensure_installed = {"clangd", "pyright", "rust_analyzer", "clojure_lsp", "eslint", "tsserver", "svelte"}})
  lspconfig.clangd.setup({capabilities = capabilities})
  lspconfig.pyright.setup({capabilities = capabilities})
  lspconfig.rust_analyzer.setup({capabilities = capabilities})
  lspconfig.clojure_lsp.setup({capabilities = capabilities})
  lspconfig.tsserver.setup({capabilities = capabilities})
  lspconfig.eslint.setup({capabilities = capabilities})
  lspconfig.svelte.setup({capabilities = capabilities})
  lspconfig.fennel_language_server.setup({capabilities = capabilities, settings = {fennel = {diagnostics = {globals = {"vim"}}}}})
  local function _3_(args)
    return luasnip.lsp_expand(args.body)
  end
  local function _4_(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    else
      return fallback()
    end
  end
  local function _6_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      return luasnip.jump(-1)
    else
      return fallback()
    end
  end
  cmp.setup({snippet = {expand = _3_}, mapping = cmp.mapping.preset.insert({["<C-u>"] = cmp.mapping.scroll_docs(-4), ["<C-d>"] = cmp.mapping.scroll_docs(-4), ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}), ["<Tab>"] = cmp.mapping(_4_, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(_6_, {"i", "s"})}), sources = {{name = "nvim_lsp"}, {name = "luasnip"}}})
  return vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("UserLspConfig", {}), callback = lsp_autocmd})
end
return dep_spec("williamboman/mason.nvim", {name = "lsp", dependencies = {"williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig", "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip", "telescope"}, config = config})
