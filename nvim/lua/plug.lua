return {
    {"rose-pine/neovim",
        name = "rose-pine",
        config = function ()
            require('rose-pine').setup({})
        end
    },
    {'nvim-tree/nvim-web-devicons', lazy = true},
    {'nvim-telescope/telescope.nvim',
        name = "telescope",
        event="VeryLazy"
    },
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
    {'goolord/alpha-nvim', lazy = true},
    {'tpope/vim-fugitive', event = "VeryLazy"},
    {'ethanholz/nvim-lastplace'},
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {}},
    {'lewis6991/gitsigns.nvim',
        event = "VeryLazy",
        config = function ()
            require('gitsigns').setup()
        end
    },
    {'mbbill/undotree',
        event = "VeryLazy",
        config = function ()
            vim.cmd("set undofile")
        end
    },
    {'dhruvasagar/vim-table-mode', event = "InsertEnter"},
    { 'echasnovski/mini.align',
        version = '*',
        event = "VeryLazy",
        config = function ()
            require('mini.align').setup()
        end
    },

    -- LSP and syntax
    {'nvim-treesitter/nvim-treesitter'},
    {'nvimtools/none-ls.nvim',
        event = "VeryLazy",
        config = function ()
            require("none")
        end
    },
    {'folke/lazydev.nvim',
        lazy = true,
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        }
    },
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- Autocompletion
    {'hrsh7th/nvim-cmp', event = "InsertEnter"},
    {'hrsh7th/cmp-buffer'},
    {'saadparwaiz1/cmp_luasnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-nvim-lua'},
    {'FelipeLema/cmp-async-path',},

    -- Snippets
    {'L3MON4D3/LuaSnip',
        event = "InsertEnter",
        config = function ()
            require("snip")
        end
    },
    {'rafamadriz/friendly-snippets', event = "VeryLazy"},
}
