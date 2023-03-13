-- [[ opts.lua ]]
local opt = vim.opt
local cmd = vim.api.nvim_command
local o = vim.o

opt.syntax = "ON"
opt.termguicolors = true
opt.number = true
opt.rnu = true
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
opt.scrolloff = 8
opt.updatetime = 750

-- COLOR STUFF
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
