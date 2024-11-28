vim.opt.signcolumn = 'yes' -- Reserve space for diagnostic icons

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

require('mason').setup()
require('mason-lspconfig').setup()

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {}
    end,
    --[[ ["rust_analyzer"] = function ()
        require("rust-tools").setup {}
    end ]]
}

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- require('lspconfig').gleam.setup({})
-- require('lspconfig').ocamllsp.setup({})

local cmp = require('cmp')

local completion = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'async_path'},
    {name = 'calc'},
    {name = 'nvim_lua'},
    {name = 'orgmode'},
    {name = 'buffer', keyword_length = 4},
}

cmp.setup({
    sources = completion,
    --[[ window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }, ]]
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
            -- require('luasnip').lsp_expand(args.body)
        end,
    },
    completion = { completeopt = 'menu,menuone,noinsert'},
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),

        -- to use tab to autocomplete --
        -- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        -- ['<C-Tab>'] = cmp.mapping.select_next_item(),
        -- ['<C-S-Tab>'] = cmp.mapping.select_prev_item(),

        -- to use enter to autocomplete --
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- to use tab to move the autocomplete --
        ['<C-P>'] = cmp.mapping.select_next_item(),
        ['<C-N>'] = cmp.mapping.select_prev_item(),
    }),
    formatting = {
        -- fields = {'menu', 'abbr', 'kind'},
        fields = {'abbr', 'kind', 'menu'},
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = '',
                luasnip = '',
                buffer = '',
                async_path = '',
                nvim_lua = '󰢱',
                calc = '󰃬',
                -- nvim_lsp = '[LSP]',
                -- luasnip = '[SNP]',
                -- buffer = '[BUF]',
                -- async_path = '[DIR]',
                -- nvim_lua = '[VIM]',
                -- calc = '[CAL]',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

-- SNIPPETS STUFF
require('luasnip.loaders.from_vscode').lazy_load()
-- require('luasnip.loaders.from_snipmate').load({ path = { '~/.config/nvim/snippets' } })
require('luasnip.loaders.from_snipmate').lazy_load()

vim.lsp.set_log_level("off")
