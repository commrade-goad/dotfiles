return {
    {'nvim-tree/nvim-web-devicons', lazy = true},
    {'nvim-lualine/lualine.nvim', lazy = true},
    {'sainnhe/gruvbox-material', lazy = true},
    {'nvim-telescope/telescope.nvim', name = "telescope"},
    {'nvim-lua/plenary.nvim', lazy = true},
    'tpope/vim-fugitive',
    {'numToStr/Comment.nvim', lazy = true},
    {'andweeb/presence.nvim', lazy = true},
    {'catppuccin/nvim', name = 'catppuccin', lazy = true},
    {'nvim-treesitter/nvim-treesitter', defaults = {
        lazy = false,
        version = nil,
    }
    },
    {'goolord/alpha-nvim', lazy = true},
    {'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }
}
