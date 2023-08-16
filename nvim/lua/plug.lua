return {
    {'nvim-tree/nvim-web-devicons', lazy = true},
    {'nvim-lualine/lualine.nvim', lazy = true},
    {'nvim-telescope/telescope.nvim', name = "telescope"},
    {'nvim-lua/plenary.nvim', lazy = true},
    {'numToStr/Comment.nvim', lazy = true},
    {'andweeb/presence.nvim', lazy = true},
    {'sainnhe/gruvbox-material', lazy = true},
    {'catppuccin/nvim', name = 'catppuccin', lazy = true},
    {'goolord/alpha-nvim', lazy = true},
    {'tpope/vim-fugitive'},
    {'ethanholz/nvim-lastplace'},
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
    -- {'kylechui/nvim-surround', event = "VeryLazy"},
    {'lewis6991/gitsigns.nvim', lazy = true},

    -- ORG MODE SUPPORT
    {'nvim-orgmode/orgmode', lazy = true},
    {'dhruvasagar/vim-table-mode'},
    ------------------------------------------

    -- LSP and syntax
    {'nvim-treesitter/nvim-treesitter'},
    {'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-calc',},
            {'FelipeLema/cmp-async-path',},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    },
    ------------------------------------------
}
