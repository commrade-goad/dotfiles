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
