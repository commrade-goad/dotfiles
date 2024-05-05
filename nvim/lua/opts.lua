-- [[ opts.lua ]]
local opt = vim.opt
local cmd = vim.api.nvim_command
local o = vim.o

local g = vim.g
g.t_co = 256
g.background = "dark"

opt.syntax = "ON"
opt.termguicolors = true
opt.number = true
opt.rnu = true
opt.timeoutlen = 500
cmd('colorscheme catppuccin-mocha')
cmd('filetype plugin on')
--o.clipboard = 'unnamedplus'
o.showmode = false
o.completeopt = 'noinsert,menuone,noselect'
o.cursorline = true
o.hidden = true
o.inccommand = 'split'
o.splitbelow = true
o.splitright = true
o.title = true
o.ttimeoutlen = 0
o.wildmenu = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.hlsearch = false
opt.incsearch =true
opt.scrolloff = 4
opt.updatetime = 50
opt.swapfile = false
-- vim.lsp.set_log_level("off")

-- NEWLINE AND ETC
-- MORE INFO : https://neovim.io/doc/user/options.html#'listchars'
--[[ vim.opt.list = true
vim.opt.listchars = {eol = '↲', space = '·', tab = " -󰌒", trail = '-', extends = '>', precedes = '<', nbsp = ' '}
vim.opt.listchars = {eol = '↲', space = '·'} ]]

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
vim.g.netrw_keepdir = 1
-- SHIFT+I > show banner
-- i > change view

-- COLOR STUFF
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
