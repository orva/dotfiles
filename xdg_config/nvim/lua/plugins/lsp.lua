-- [nfnl] Compiled from lua/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("util")
local dep_spec = _local_1_["dep-spec"]
local function vcs_root_dir()
  local lsp_utils = require("lspconfig.util")
  return lsp_utils.root_pattern(".jj", ".git")
end
local function marksman_root_dir()
  local lsp_utils = require("lspconfig.util")
  local config_match = lsp_utils.root_pattern(".marksman.toml")
  local vcs_match = vcs_root_dir()
  local function _2_(fname)
    return (config_match(fname) or vcs_match(fname))
  end
  return _2_
end
local function lsp_autocmd(ev)
  local telescope = require("telescope.builtin")
  local opts = {buffer = ev.buf}
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gs", telescope.lsp_workspace_symbols, opts)
  vim.keymap.set("n", "gt", telescope.lsp_type_definitions, opts)
  vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
  vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
  vim.keymap.set("n", "gr", telescope.lsp_references, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
  local function _3_()
    return vim.lsp.buf.format({async = true})
  end
  return vim.keymap.set("n", "<space>f", _3_, opts)
end
local function config()
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")
  local lspconfig = require("lspconfig")
  local lsp_utils = require("lspconfig.util")
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local capabilities = cmp_nvim_lsp.default_capabilities()
  mason.setup()
  mason_lspconfig.setup({ensure_installed = {"clangd", "pyright", "rust_analyzer", "clojure_lsp", "tsserver", "fennel_language_server", "marksman"}})
  lspconfig.clangd.setup({capabilities = capabilities})
  lspconfig.pyright.setup({capabilities = capabilities})
  lspconfig.rust_analyzer.setup({capabilities = capabilities})
  lspconfig.clojure_lsp.setup({capabilities = capabilities})
  lspconfig.tsserver.setup({capabilities = capabilities})
  lspconfig.fennel_language_server.setup({capabilities = capabilities, root_dir = vcs_root_dir(), settings = {fennel = {diagnostics = {globals = {"vim"}}}}, single_file_support = false})
  lspconfig.marksman.setup({capabilities = capabilities, filetypes = {"markdown", "md", "mdx"}, root_dir = marksman_root_dir(lsp_utils), single_file_support = false})
  local function _4_(args)
    return luasnip.lsp_expand(args.body)
  end
  local function _5_(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
      return luasnip.expand_or_jump()
    else
      return fallback()
    end
  end
  local function _7_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      return luasnip.jump(-1)
    else
      return fallback()
    end
  end
  cmp.setup({snippet = {expand = _4_}, mapping = cmp.mapping.preset.insert({["<C-u>"] = cmp.mapping.scroll_docs(-4), ["<C-d>"] = cmp.mapping.scroll_docs(-4), ["<C-Space>"] = cmp.mapping.complete(), ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}), ["<Tab>"] = cmp.mapping(_5_, {"i", "s"}), ["<S-Tab>"] = cmp.mapping(_7_, {"i", "s"})}), sources = {{name = "nvim_lsp"}, {name = "luasnip"}}})
  return vim.api.nvim_create_autocmd("LspAttach", {group = vim.api.nvim_create_augroup("UserLspConfig", {}), callback = lsp_autocmd})
end
return dep_spec("williamboman/mason.nvim", {name = "lsp", dependencies = {"williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig", "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip", "snippets", "telescope"}, config = config})
