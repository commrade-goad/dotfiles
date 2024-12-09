return {
    {'nvim-tree/nvim-web-devicons', lazy = true},
    {'nvim-lualine/lualine.nvim', lazy = true},
    {'nvim-telescope/telescope.nvim', name = "telescope"},
    {'nvim-lua/plenary.nvim', lazy = true},
    {'numToStr/Comment.nvim', lazy = true},
    {'andweeb/presence.nvim', lazy = true},
    -- {'sainnhe/gruvbox-material', lazy = true},
    -- {'catppuccin/nvim', name = 'catppuccin', lazy = true},
    {'shaunsingh/nord.nvim', name = 'nord', lazy = true},
    {'goolord/alpha-nvim', lazy = true},
    {'tpope/vim-fugitive', lazy = true},
    {'ethanholz/nvim-lastplace'},
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
    {'lewis6991/gitsigns.nvim', lazy = true},
    -- {'lukas-reineke/indent-blankline.nvim'},
    {'uga-rosa/ccc.nvim', lazy = true},
    {'vidocqh/auto-indent.nvim', lazy = true},
    {'mbbill/undotree', lazy = true},
    {'dhruvasagar/vim-table-mode', lazy = true},
    {'windwp/nvim-ts-autotag', lazy = true},

    ------------------------------------------

    -- LSP and syntax
    {'nvim-treesitter/nvim-treesitter'},
    {'nvimtools/none-ls.nvim'},
    {'folke/lazydev.nvim',
        lazy = true,
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        }
    },
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-buffer'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
    -- {'hrsh7th/cmp-calc',},
    {'FelipeLema/cmp-async-path',},

    -- Snippets
    {'L3MON4D3/LuaSnip'},
    {'rafamadriz/friendly-snippets'},
    ------------------------------------------
}
