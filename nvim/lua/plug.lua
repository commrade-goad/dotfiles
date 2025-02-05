return {
    {'nvim-tree/nvim-web-devicons', lazy = true},
    {'nvim-telescope/telescope.nvim', name = "telescope"},
    {'nvim-lua/plenary.nvim', lazy = true},
    {"folke/which-key.nvim",
        event = "VeryLazy",
        opts = { preset = "helix", timeoutlen = 1500 },
        keys = {
            {"<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    -- {'sainnhe/gruvbox-material', lazy = true},
    -- {'catppuccin/nvim', name = 'catppuccin', lazy = true},
    {'gbprod/nord.nvim', name = 'nord'},
    {'goolord/alpha-nvim', lazy = true},
    {'tpope/vim-fugitive'},
    {'ethanholz/nvim-lastplace', lazy = true},
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
    {'lewis6991/gitsigns.nvim', lazy = true},
    -- {'uga-rosa/ccc.nvim', lazy = true},
    -- {'vidocqh/auto-indent.nvim', lazy = true},
    {'mbbill/undotree'},
    {'dhruvasagar/vim-table-mode'},
    -- {'windwp/nvim-ts-autotag', lazy = true},
    -- {'stevearc/oil.nvim',
    --     opts = {},
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- },

    ------------------------------------------

    -- LSP and syntax
    {'nvim-treesitter/nvim-treesitter'},
    {'nvimtools/none-ls.nvim', lazy = true},
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
