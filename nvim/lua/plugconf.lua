require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = "gruvbox-material",
        component_separators = { left = '|', right = '|'},
        -- component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {'packer', 'NvimTree', 'alpha'},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        -- lualine_c = {'filename', 'buffers'},
        lualine_c = {'buffers'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        -- lualine_x = {'encoding', 'fileformat'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
-- require('bufferline').setup{}
require('catppuccin')
require('Comment').setup()
-- require('nvim-autopairs').setup({
--   disable_filetype = { 'TelescopePrompt' , 'vim' },
-- })
require('presence'):setup()
require('telescope').setup()
-- require('command-completion').setup()

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {"c", "cpp", "rust", "python", "lua"},
    sync_install = false,

    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        disable = {},
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_decremental = "grm",
            node_incremental = "grn",
            scope_incremental = "grc"
        },
    },
    indent = {
        disable = {},
        enable = true,
    }
}

-- SNIPPETS STUFF
-- require('luasnip.loaders.from_vscode').lazy_load()
-- require('luasnip.loaders.from_snipmate').load({ path = { '~/.config/nvim/snippets' } })
-- require('luasnip.loaders.from_snipmate').lazy_load()
