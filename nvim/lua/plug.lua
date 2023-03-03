-- [[ plug.lua ]]
return require('packer').startup(function(use)
  -- [[ Plugins Go Here ]]
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
	'nvim-lualine/lualine.nvim'
  }
  use {
	'catppuccin/nvim', as = 'catppuccin'
  }
  use {
	'nvim-treesitter/nvim-treesitter',
	run = function()
            	local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            	ts_update()
        end,
  }
  use {
	'windwp/nvim-autopairs',
	config = function() require("nvim-autopairs").setup {} end,
  }
  use {
  	'nvim-telescope/telescope.nvim', tag = '0.1.x',
  	requires = {'nvim-lua/plenary.nvim'}
}
  use {
	'ap/vim-css-color'

  }
  use ('tpope/vim-fugitive')
  -- use ('andweeb/presence.nvim')
  -- LSP
  use {
  'VonHeikemen/lsp-zero.nvim',
  requires = {
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
end,
{
  config = {
    package_root = vim.fn.stdpath('config') .. '/site/pack'
  }
})

