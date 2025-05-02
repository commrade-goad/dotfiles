return {
    {"RRethy/base16-nvim",
        config = function ()
            local custom_color = require('plugconf.custom-color')
            require('base16-colorscheme').setup(custom_color)
        end
    },
    {"nvim-telescope/telescope.nvim",
        name = "telescope",
        event= "VeryLazy"
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
    {'tpope/vim-fugitive', event = "VeryLazy"},
    {'dhruvasagar/vim-table-mode', event = "InsertEnter"},

    {'nvim-treesitter/nvim-treesitter',
        event = "VeryLazy",
        config = function()
            require("plugconf.treesitter")
        end
    },

    {'neovim/nvim-lspconfig'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    {'hrsh7th/nvim-cmp', event = "InsertEnter"},
    {'hrsh7th/cmp-buffer', event = "InsertEnter"},
    {'saadparwaiz1/cmp_luasnip', event = "InsertEnter"},
    {'hrsh7th/cmp-nvim-lsp', event = "InsertEnter"},
    {'FelipeLema/cmp-async-path', event= "InsertEnter"},

    {'L3MON4D3/LuaSnip',
        event = "InsertEnter",
        config = function ()
            require("plugconf.luasnip")
        end
    },
}
