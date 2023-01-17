--[[ keys.lua ]]
local map = vim.api.nvim_set_keymap

-- remap the key used to leave insert mode
map('i', 'jk', '', {})

-- Toggle nvim-tree
map('n', '<F3>', [[:NvimTreeToggle<CR>]], {})

vim.g.mapleader = " "
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({search = vim.fn.input("Grep : ")})
end)

vim.keymap.set('n', "<leader>f", vim.cmd.Ex)
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('v', '<C-y>', "\"+y" )
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.api.nvim_set_keymap("n", "<leader>t", ":tabe .<CR>", {noremap=true})
-- to move around in tab use 'gt' or 'gT'
