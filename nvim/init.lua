-- IMPORTS
require('vars')         -- Variables
require('opts')         -- Options
require('keys')         -- Keymaps
require('plug')         -- Plugins: UNCOMMENT THIS LINE
require('lspconf')
-- require('lsptesting')
-- require('coc')

-- PLUGINS: Add this section
require('nvim-tree').setup{
    sync_root_with_cwd = true
}
require('lualine').setup{
	options = {
        theme = 'catppuccin',
        disabled_filetypes = {'packer', 'NvimTree'}}
}
require('catppuccin')
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
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
