require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "rust", "python", "lua"},
    sync_install = false,

    modules = {},
    ignore_install = {},
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

require('nvim-lastplace').setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help", "alpha"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}
