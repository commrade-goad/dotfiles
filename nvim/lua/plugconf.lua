require('lualine').setup{
    options = {
        icons_enabled = true,
        theme = "nord",
        -- component_separators = { left = '|', right = '|'},
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {'NvimTree', 'alpha'},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 200,
            tabline = 500,
            winbar = 500,
        }
    },
    sections = {
        -- new style
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        -- lualine_c = {'buffers'},
        lualine_c = {'filename'},
        lualine_x = {'fileformat','location', 'filetype'},
        lualine_y = {'diagnostics'},
        lualine_z = {}
        ----------------------------
        -- lualine_a = {'mode'},
        -- lualine_b = {'branch', 'diff','diagnostics'},
        -- lualine_c = {'filename'},
        -- lualine_x = {'encoding', 'fileformat', 'filetype'},
        -- lualine_y = {'progress'},
        -- lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'fileformat', 'location', 'filetype'},
        lualine_y = {'diagnostics'},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
-- require('catppuccin')

require('nord')
vim.g.nord_contrast = true
vim.g.nord_disable_background = true

require('Comment').setup()
require("presence").setup({})
require('telescope').setup({})
-- require('command-completion').setup()

require'nvim-treesitter.configs'.setup {
    ensure_installed = {"c", "cpp", "rust", "python", "lua"},
    sync_install = false,

    modules = {},
    ignore_install = {},
    auto_install = true,
    highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = false,
        additional_vim_regex_highlighting = {'markdown'},
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

require('nvim-lastplace').setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help", "alpha"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

require('gitsigns').setup()

local ccc = require("ccc")
-- local mapping = ccc.mapping

ccc.setup({
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})


require("auto-indent").setup({
  lightmode = false,        -- Lightmode assumes tabstop and indentexpr not change within buffer's lifetime
  indentexpr = nil,        -- Use vim.bo.indentexpr by default, see 'Custom Indent Evaluate Method'
  ignore_filetype = {},    -- Disable plugin for specific filetypes, e.g. ignore_filetype = { 'javascript' }
})

-- INDENT STYLE
-- LINK : https://github.com/lukas-reineke/indent-blankline.nvim
-- require("ibl").setup()
--[[ local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
} ]]

-- AUTO CLOSE HTML TAGS
require('nvim-ts-autotag').setup({
    opts = {
        -- Defaults
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
        ["html"] = {
            enable_close = false
        }
    }
})
