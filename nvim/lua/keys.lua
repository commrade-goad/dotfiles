--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
-- map('i', 'jk', '', {})

-- netrw
map('n', '<F3>', [[:e .<CR>]], {}) -- refresh netrw view
map('n', '<F4>', [[:tabe <CR>]], {}) -- new empty buffer (tmp)
vim.api.nvim_set_keymap("v", "mf", ":normal mf<CR>", {noremap=true}) -- [space] + l to go to the next buffer

vim.g.mapleader = " "
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- telescope with cwd
vim.keymap.set('n', '<C-p>', builtin.git_files, {}) -- telescope with git files
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({search = vim.fn.input("Find text : ")}) -- findout some text on the working dir using [space]+f+s
end)

vim.keymap.set('n', "<leader>f", vim.cmd.Ex) -- open netrw with [space]+f
vim.keymap.set('n', '<leader>gs', vim.cmd.Git) -- git repos stuff with [space]+g+s

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- move out text
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv") -- move out text

vim.keymap.set('v', '<C-y>', "\"+y" ) -- Yank/copy some text with ctrl+y on visual mode
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- subtitute selected text with [space]+s
vim.api.nvim_set_keymap("n", "<leader>t", ":tabe .<CR>", {noremap=true}) -- open up new tab on normal mode with [space]+t

vim.api.nvim_set_keymap("n", "<leader>l", ":bNext<CR>", {noremap=true}) -- [space] + l to go to the next buffer
vim.api.nvim_set_keymap("n", "<leader>bb", ":Telescope buffers<CR>", {noremap=true}) -- [space] + b + b to spawn telescope that show opened buffer


-- NUMBERING STUFF
-- to do numbering u can do with `:put=range(first number,last number, increment)`
-- after duplicate downward and need to number it can use `[visual block] and g+Ctrl+a`
    -- MORE BETTER IMPLEMENTATION
    -- feature that automatically increment numbers with <C-a> (and decrement with <C-x>).
    -- We can also change the increments by inserting a number ahead. If we want to have `10,20,30,...` instead of 1,2,3,..., do `10g<C-a>` instead.

-- BASIC
-- to move around in tab use 'gt' or 'gT'
-- shift+k is a LSP jumping ones
-- [Ctrl]+r is redo
-- db is delete backward
-- dw is delete word
-- `ctr+{`, `ctrl+c` will exit insert mode like
-- [INSER MODE STUFF] normal mode {a, i} => `a` is `forward` meanwhile `i` is `backward`
-- y5j => will copy 1 until line 5 below
-- Ctrl+^ and [leader]l => jump to previous file (opened one)
-- ci" => jump to previous string and delete the content
-- ciw => cutout word
-- * on word to seach the word
-- % to jump to closing or opening brackets
-- ( to go back to last sentence or go to next whitespace
-- ) to go forward the current sentence or go to next whitespace
-- :bd close current active buffer
-- create term => terminal or term

-- SPLIT STUFF
-- create term split => split term://zsh
-- resize split => Ctrl+w+n+(-, +, <, >)    example : Ctrl+w+5+-
-- maximize split => Ctrl+w+_
-- same size split => Ctrl+w+=
-- Ctrl+w+v => open vsplit
-- Ctrl+w+s => open horizontal split

-- COMMENT PLUGIN
-- visual mode => `gc`, `gb`
-- normal mode => `gcc`, `gbc`

-- NETRW BIND
-- % => create new file
-- d => create dir
-- D => delete file
-- mf => markfile
-- r => descending ascending
-- R => moving file
-- mt => marktarget
-- mc => copy
