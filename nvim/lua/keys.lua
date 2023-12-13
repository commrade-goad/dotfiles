local nvim_cc = require('nvim-cc')
local map = vim.api.nvim_set_keymap
local common = {noremap = true}
-- map("i", "jk", "<ESC>", {})
-- vim.g.mapleader = " "

-- SPECIAL 
map("v", "<leader>y", "\"+y" , common) -- Yank/copy some text with [space]+y on visual mode
map("n", "<leader>t", ":tabe .<CR>", common) -- open up new tab on normal mode with [space]+t
map("n", "<leader>h", ":tab Alpha<CR>", common) -- open up alpha with [space]h 
map("n", "<leader>gs", ":Git<CR>", common) -- git repos stuff with [space]+g+s
map("n", "<leader>gsd", ":Git diff<CR>", common) -- git diff with [space]+g+s+d
map("n", "<leader>gp", ":Git push<CR>", common)
map("t", "<Esc>", "<C-\\><C-n>", common) -- exit term mode with esc
map("v", "J", ":m '>+1<CR>gv=gv", common) -- move out text
map("v", "K", ":m '<-2<CR>gv=gv", common) -- move out text
map("v", "mf", ":normal mf<CR>", common) -- for netrw markfile
map("n", "<leader><leader>x", "<cmd>source %<CR>", common) -- source a lua file
map("n", "<leader>pc", "<cmd>CccPick<CR>", common) -- color picker
map("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", common) -- undo tree
----------------------------------------

-- L CATEGORY / CUSTOM LSP BIND
map("n", "<leader>lr", ":Telescope lsp_references<CR>", common) -- telescope lsp references [space]lr
map("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", common) -- code action with [space]la
map("n", "<leader>ld", ":Telescope diagnostics<CR>", common) -- diagnostics use Ctrl+q to spawn quickfix buffer
map("n", "<leader>lf", ":set foldmethod=expr<CR>", common) -- activate fold to the current buffer and toggle with za
map("n", "<leader>lfb", ":lua vim.lsp.buf.format()<CR>", common) -- format code
map("n", "<leader>lqf", ":lua vim.diagnostic.setqflist()<CR>", common) -- quickfix list
----------------------------------------

-- F CATEGORY / THE FILE FUNC
map("n", "<leader>ff", ":Telescope find_files<CR>", common) -- telescope with cwd
map("n", "<leader>fr", ":Telescope oldfiles<CR>", common) -- telescope with oldfiles
map("n", "<leader>fp", ":Telescope git_files<CR>", common) -- telescope with git files
map("n", "<leader>f", ":Ex<CR>", common) -- open netrw with [space]+f
----------------------------------------

-- C CATEGORY / THE COMPILE FUNC
vim.keymap.set("n", "<leader>cC", function () nvim_cc.input_compile_command() end) -- compile command input
-- vim.keymap.set("n", "<leader>cc", function () nvim_cc.run_compile_command() end) -- run compile command
vim.keymap.set("n", "<leader>cc", function ()
    if Nvim_cc_term_buffn == nil or vim.fn.bufexists(Nvim_cc_term_buffn) ~= 1 then
        nvim_cc.run_compile_command()
    else
        print("The compile command buff already running...")
    end
end) -- run compile command
vim.keymap.set("n", "<leader>cd", function () nvim_cc.run_compile_command_silent() end) -- compile command default or silent
vim.keymap.set("n", "<leader>cf", function () nvim_cc.set_compile_command_from_file() end) -- set compile command from file
vim.keymap.set("n", "<leader>cs", function () -- sync file dir to current dir and do <leader>cf auto
    nvim_cc.sync_directory_to_buffer()
    nvim_cc.set_compile_command_from_file()
    print("cwd & cc set.")
end)
----------------------------------------

-- S CATEGORY / THE SEARCH/SUBTITUTE FUNC
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], common) -- subtitute word with [space]+s
map("n", "<leader>sw", "<cmd>normal! *<CR>", common) -- search text with [space]+sw
map("n", "<leader>sb", "<cmd>normal! #<CR>", common) -- search text with [space]+sb
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], common) -- subtitute word with [space]+ss with choice
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", common) -- search vim help [space]+sh
vim.keymap.set("n", "<leader>fs", function()
    local builtin = require("telescope.builtin")
    builtin.grep_string({search = vim.fn.input("Find String : ")}) -- findout some text on the working dir using [space]+f+s
end)
----------------------------------------

-- B CATEGORY / THE BUFFER FUNC
map("n", "<leader>be", [[:tabe <CR>]], {}) -- new empty buffer tab (tmp)
map("n", "<leader>bn", ":bNext<CR>", common) -- [space] + l to go to the next buffer
map("n", "<leader>bp", ":bprev<CR>", common) -- [space] + l to go to the next buffer
map("n", "<leader>bl", ":Telescope buffers<CR>", common) -- [space] + b + b to spawn telescope that show opened buffer
map("n", "<leader>bs", ":vsp | Telescope buffers<CR>", common) -- select buffer then do vertical split
map("n", "<leader>bc", ":bd!<CR>", common) -- remove / delete buffer
----------------------------------------

-- J CATEGORY / THE JUMP FUNC
map("n", "<leader>jj", "<cmd>normal! %<CR>", common) -- jump parent
map("n", "<leader>jh", "<cmd>normal! ^<CR>", common) -- jump first
map("n", "<leader>jl", "<cmd>normal! $<CR>", common) -- jump last
map("v", "<leader>jj", "<cmd>normal! %<CR>", common) -- jump parent
map("v", "<leader>jh", "<cmd>normal! ^<CR>", common) -- jump first
map("v", "<leader>jl", "<cmd>normal! $<CR>", common) -- jump last
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

-- f<char> => jump to next specified char 
-- F<char> => jump to prev specified char 
-- t<char> => jump to next before the specified char 
-- T<char> => jump to prev before the specified char 
-- ; => to repeat the jump next
-- , => to repeat the jump prev 
-- w => word
-- W => WORD
-- b => back
-- B => BACK
-- e => next end of word
-- E => next end of WORD
-- ge => prev end of word
-- gE => prev end of WORD
-- { and } => paragraf
-- ]) or [(   ||   ]} and [{ to jump to close n open with the cursor in neither
-- Ctrl+e down and Ctrl+y up
-- <n>G => jump with jumplist
-- Ctrl+O and Ctrl+I => prev and next jumplist
-- . => repeat c and d mode => cw cb dw db
-- :.!<cmd> => pass the currnet line or selection to shell and capture the output
-- :,+5.!tac => reverse 5j
-- "<a-z>y => to yank to certain register
-- "<a-z>p => to paste from certain register
-- ci" => same as di" and enter insert mode     -\
-- di" => delete inside "                       --- can be customized to use ( [ {
-- yi" => yank inside "                         _/
-- ct<char> => change any string until the specified char
-- ciw => cutout word same as cw

-- [INSERT MODE] Ctrl+w => delete backward like db
-- [INSERT MODE] Ctrl+u => delete all characters backward 
-- [INSERT MODE] Ctrl+o => go to command mode on insert mode
-- mark -> create inside buffer mark with `m[a-z]` jump using `[a-z]
-- mark -> create buffer mark with `m[A-Z]` jump using `[A-Z]

-- MACRO
-- record => q<a-z>
-- exit record => q
-- do the macro => @<a-z>
----------------

-- LSP
----------------
-- K: vim.lsp.buf.hover()
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

-- gf: go file
-- :copen : open quickfix

-- [I: find the word
-- [<tab>: jump to the word
-- _ : the same as ^
-- I = go to first nonwhitespace char on line and enter insert mode
-- A = go to last nonwhitespace char on line and enter insert mode
-- > : on visual mode to tab
-- < : on visual mode to tab
-- visual mode then do `:!` to pipe your selected text to shell command
-- visual mode do gq to hardformat text
-- gj and gk to go up and down visual line (linewrap)

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
