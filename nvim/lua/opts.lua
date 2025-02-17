local opt = vim.opt
local cmd = vim.api.nvim_command
local o = vim.o

local g = vim.g
g.background = "dark"

opt.termguicolors = true
opt.number = true
opt.rnu = true
opt.timeoutlen = 500
-- cmd('colorscheme base16-rose-pine')

cmd('filetype plugin on')
-- o.clipboard = 'unnamedplus' -- to use system clipboard

o.showmode = false

o.completeopt = 'noinsert,menuone,noselect'
o.ignorecase = true -- case insensitive search
o.cursorline = true
o.hidden = true
o.inccommand = 'split'
o.splitbelow = true
o.splitright = true
o.title = false
o.ttimeoutlen = 0
o.wildmenu = true
-- opt.guicursor = "n-v-c-i-ci-ve-sm:block,r-cr-o:hor20"
-- opt.guicursor = "n-v-i-c:block-Cursor"
-- opt.colorcolumn="80"
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.hlsearch = false
opt.incsearch =true
opt.scrolloff = 3
opt.updatetime = 50
opt.swapfile = false

-- NEWLINE AND ETC
-- MORE INFO : https://neovim.io/doc/user/options.html#'listchars'
vim.opt.list = true
-- vim.opt.listchars = {eol = '↲', tab = "··>", space = "·", multispace = "   ~"}
vim.opt.listchars = {eol = '↲', tab = "··>"}

-- FOLD
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = -1

-- NETRW STUFF
vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0
vim.g.netrw_sizestyle= "h"
vim.g.netrw_winsize = 25
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localrmdir = "rm -r"
vim.g.netrw_keepdir = 0

-- SHIFT+I > show banner
-- i > change view

-- ZIG WHY?????
vim.cmd("let g:zig_fmt_autosave = 0")

-- COLOR STUFF
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})

-- RESTORE CURSOR POSITION
vim.api.nvim_create_autocmd('BufRead', {
    callback = function(opts)
        vim.api.nvim_create_autocmd('BufWinEnter', {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match('commit') and ft:match('rebase'))
                    and last_known_line > 1
                    and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], 'nx', false)
                end
            end,
        })
    end,
})
