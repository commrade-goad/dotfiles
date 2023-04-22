-- IMPORTS
require('vars')         -- Variables
require('plug')         -- Plugins: UNCOMMENT THIS LINE
require('opts')         -- Options
require('keys')         -- Keymaps
require('lspconf')
-- require('lsptesting')
-- require('coc')
-- '=' is indent

-- PLUGINS: Add this section
--require('nvim-tree').setup{
--    sync_root_with_cwd = true
--}
require'netrw'.setup()
require('lualine').setup{
	options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {'packer', 'NvimTree'}
	},
}
require('catppuccin')
require('Comment').setup()
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
require("presence"):setup()
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
  },
  extensions = {
  }
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "python" },
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}

-- SNIPPETS STUFF
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").load({ path = { "~/.config/nvim/snippets" } })
require("luasnip.loaders.from_snipmate").lazy_load()

-- FIX NVIM_TREE
-- local function open_nvim_tree(data)
--   -- buffer is a directory
--   local directory = vim.fn.isdirectory(data.file) == 1
--   if not directory then
--     return
--   end
--   -- change to the directory
--   vim.cmd.cd(data.file)
--   -- open the tree
--   require("nvim-tree.api").tree.open()
-- end
-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
