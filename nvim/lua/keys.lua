local nvim_cc = require('nvim-cc')
local map = vim.api.nvim_set_keymap
-- map("i", "jk", "<ESC>", {})
-- vim.g.mapleader = " "

-- SPECIAL 
map("v", "<leader>y", "\"+y" , {noremap=true}) -- Yank/copy some text with ctrl+y on visual mode
map("n", "<leader>t", ":tabe .<CR>", {noremap=true}) -- open up new tab on normal mode with [space]+t
map("n", "<leader>h", ":tab Alpha<CR>", {noremap=true}) -- open up alpha with [space]h 
map("t", "<Esc>", "<C-\\><C-n>", {noremap = true}) -- exit term mode with esc
map("v", "J", ":m '>+1<CR>gv=gv", {noremap=true}) -- move out text
map("v", "K", ":m '<-2<CR>gv=gv", {noremap=true}) -- move out text
map("n", "<F5>", [[:e .<CR>]], {}) -- refresh netrw view
map("v", "mf", ":normal mf<CR>", {noremap=true}) -- for netrw markfile
map("n", "<leader>gs", ":Git<CR>", {noremap=true}) -- git repos stuff with [space]+g+s
----------------------------------------

-- F CATEGORY / THE FILE FUNC
local builtin = require("telescope.builtin")
map("n", "<leader>ff", ":Telescope find_files<CR>", {noremap=true}) -- telescope with cwd
-- map("n", "<leader>ffs", ":vsp | Telescope find_files<CR>", {noremap=true}) -- find files and open it on vsplit
map("n", "<leader>fr", ":Telescope oldfiles<CR>", {noremap=true}) -- telescope with oldfiles
map("n", "<leader>fp", ":Telescope git_files<CR>", {noremap=true}) -- telescope with git files
map("n", "<leader>f", ":Ex<CR>", {noremap=true}) -- open netrw with [space]+f
vim.keymap.set("n", "<leader>fs", function()
   builtin.grep_string({search = vim.fn.input("Find String : ")}) -- findout some text on the working dir using [space]+f+s
end)
----------------------------------------

-- C CATEGORY / THE COMPILE FUNC
vim.keymap.set("n", "<leader>cC", function () nvim_cc.input_compile_command() end)
vim.keymap.set("n", "<leader>cc", function () nvim_cc.run_compile_command() end)
vim.keymap.set("n", "<leader>cs", function () nvim_cc.run_compile_command_silent() end)
vim.keymap.set("n", "<leader>cf", function () nvim_cc.set_compile_command_from_file() end)
----------------------------------------

-- R CATEGORY / THE RUN FUNC
vim.keymap.set("n", "<leader>rR", function () nvim_cc.input_run_command() end)
vim.keymap.set("n", "<leader>rr", function () nvim_cc.run_run_command() end)
----------------------------------------

-- S CATEGORY / THE SYNC FUNC
vim.keymap.set("n", "<leader>sd", function () -- sync file dir to current dir
    nvim_cc.sync_directory_to_buffer()
    nvim_cc.set_compile_command_from_file()
    print("cwd & cc set.")
end)
----------------------------------------

-- B CATEGORY / THE BUFFER FUNC
map("n", "<leader>be", [[:tabe <CR>]], {}) -- new empty buffer (tmp)
map("n", "<leader>bn", ":bNext<CR>", {noremap=true}) -- [space] + l to go to the next buffer
map("n", "<leader>bl", ":Telescope buffers<CR>", {noremap=true}) -- [space] + b + b to spawn telescope that show opened buffer
map("n", "<leader>bs", ":vsp | Telescope buffers<CR>", {noremap=true}) -- select buffer then do vertical split
map("n", "<leader>bc", ":bd!<CR>", {noremap=true}) -- remove / delete buffer
----------------------------------------

-- S CATEGORY / THE SUBTITUTE FUNC
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {noremap=true}) -- subtitute selected text with [space]+s
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], {noremap=true}) -- subtitute selected text with [space]+ss with choice
map("v", "<leader>s", [[:s///gIc<Left><Left><Left><left><left>]], {noremap=true}) -- subtitute selected text with [space]+s
----------------------------------------

-------------------------------------------------------------
-- NOTE
-------------------------------------------------------------

-- NUMBERING STUFF
----------------
-- to do numbering u can do with `:put=range(first number,last number, increment)`
-- after duplicate downward and need to number it can use `[visual block] and g+Ctrl+a`
-- feature that automatically increment numbers with <C-a> (and decrement with <C-x>).
-- We can also change the increments by inserting a number ahead. If we want to have `10,20,30,...` instead of 1,2,3,..., do `10g<C-a>` instead.

-- BASIC
----------------
-- to move around in tab use 'gt' or 'gT'
-- shift+k is a LSP jumping ones
-- [Ctrl]+r is redo
-- db is delete backward
-- dw is delete word
-- `ctr+{`, `ctrl+c` will exit insert mode
-- [INSER MODE STUFF] normal mode {a, i} => `a` is `forward` meanwhile `i` is `backward`
-- y5j => will copy 1 until line 5 below
-- Ctrl+^ => jump to previous file (opened one)
-- ci" => same as di" and enter insert mode
-- di" => delete inside "
-- ciw => cutout word
-- yi" => yank inside "
-- Ctrl+u => go to the top
-- Shift+d => delete front char
-- Close buffer with Ctrl+w+c
-- Delete delete char to right
-- * on word to seach the word
-- % to jump to closing or opening brackets
-- ( to go back to last sentence or go to next whitespace
-- ) to go forward the current sentence or go to next whitespace
-- :bd close current active buffer
-- create term => terminal or term
-- goto normal mode in terminal => Ctrl+\+Ctrl+n
-- :w [name] is the equivalent of save as
-- :e to edit in current tabs or whatever that will spawn new buffer
-- f" => jump to next quote
-- [INSERT MODE] Ctrl+w => delete backward like db
-- [INSERT MODE] Ctrl+u => delete all characters backward 
-- [INSERT MODE] Ctrl+o => go to command mode on insert mode

-- LSP
----------------
-- gd: Jumps to the definition of the symbol under the cursor. See :help vim.lsp.buf.definition().
-- gD: Jumps to the declaration of the symbol under the cursor. Some servers don't implement this feature. See :help vim.lsp.buf.declaration().
-- gi: Lists all the implementations for the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.implementation().
-- go: Jumps to the definition of the type of the symbol under the cursor. See :help vim.lsp.buf.type_definition().
-- gr: Lists all the references to the symbol under the cursor in the quickfix window. See :help vim.lsp.buf.references().
-- gs: Displays signature information about the symbol under the cursor in a floating window. See :help vim.lsp.buf.signature_help(). If a mapping already exists for this key this function is not bound.
-- <F2>: Renames all references to the symbol under the cursor. See :help vim.lsp.buf.rename().
-- <F3>: Format code in current buffer. See :help vim.lsp.buf.format().
-- <F4>: Selects a code action available at the current cursor position. See :help vim.lsp.buf.code_action().
-- gl: Show diagnostics in a floating window. See :help vim.diagnostic.open_float().
-- [d: Move to the previous diagnostic in the current buffer. See :help vim.diagnostic.goto_prev().
-- ]d: Move to the next diagnostic. See :help vim.diagnostic.goto_next().

-- SPLIT STUFF
----------------
-- create term split => split term://zsh
-- resize split => Ctrl+w+n+(-, +, <, >)    example : Ctrl+w+5+-
-- maximize split => Ctrl+w+_
-- same size split => Ctrl+w+=
-- Ctrl+w+v => open vsplit
-- Ctrl+w+s => open horizontal split

-- COMMENT PLUGIN
----------------
-- visual mode => `gc`, `gb`
-- normal mode => `gcc`, `gbc`

-- NETRW BIND
----------------
-- % => create new file
-- d => create dir
-- D => delete file
-- mf => markfile
-- r => descending ascending
-- R => moving file
-- mt => marktarget
-- mc => copy

-- GIT
----------------
-- = to look diff
-- s to save the selected line or file
-- zz stash change
-- cc to commit
