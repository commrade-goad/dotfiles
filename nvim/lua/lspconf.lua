vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'eslint',
})

lsp.nvim_workspace()

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = 'x',
    warn = '!',
    hint = 'H',
    info = 'i'
  }
})

lsp.setup_nvim_cmp({
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
})

lsp.setup()
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = true,
})

local cmp = require('cmp')
local completion = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'async_path'},
    {name = 'calc'},
    {name = 'nvim_lua'},
    {name = 'orgmode'},
    {name = 'buffer'},
}
-- all source here : https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = false}),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = completion,
})

-- CUSTOM COMMAND = BAD
-- local lspconfig = require('lspconfig')
-- lspconfig.clangd.setup{
--     cmd = {"clangd", "--compile-commands-dir=compiledb/", "--background-index", "--clang-tidy"},
-- }

-- SNIPPETS STUFF
-- require('luasnip.loaders.from_vscode').lazy_load()
-- require('luasnip.loaders.from_snipmate').load({ path = { '~/.config/nvim/snippets' } })
-- require('luasnip.loaders.from_snipmate').lazy_load()
