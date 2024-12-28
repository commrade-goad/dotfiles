Nvim_cc_start_insert = false
Nvim_cc_blacklist_dir_name = {"src", "bin"}
local nvim_cc = require('nvim-cc')
local map = vim.api.nvim_set_keymap
local common = {noremap = true, silent = true}

-- ----------------------------------------
-- map("v", "<leader>y", "\"+y", common) -- Yank/copy some text with [space]+y on visual mode
-- map("n", "<leader>t", ":tabe .<CR>", common) -- open up new tab on normal mode with [space]+t
-- map("n", "<leader>h", ":tab Alpha<CR>", common) -- open up alpha with [space]h 
-- map("n", "<leader>gs", ":Git<CR>", common) -- git repos stuff with [space]+g+s
-- map("n", "<leader>gsd", ":Git diff<CR>", common) -- git diff with [space]+g+s+d
-- map("n", "<leader>gp", ":Git push<CR>", common)
-- map("t", "<leader><Esc>", "<C-\\><C-n>", common) -- exit term mode with [space] esc
-- map("n", "<Esc>", ":noh<CR>", common) -- esc will clean search hl
-- map("v", "<C-j>", ":m '>+1<CR>gv=gv", common) -- move out text
-- map("v", "<C-k>", ":m '<-2<CR>gv=gv", common) -- move out text
-- map("n", "<C-j>", ":m '>+1<CR>gv=gv", common) -- move out text
-- map("n", "<C-k>", ":m '<-2<CR>gv=gv", common) -- move out text
-- map("v", "mf", ":normal mf<CR>", common) -- for netrw markfile
-- map("n", "<leader><leader>x", "<cmd>source %<CR>", common) -- source a lua file
-- map("n", "<leader>pc", "<cmd>CccPick<CR>", common) -- color picker
-- map("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", common) -- undo tree
-- vim.keymap.set("n", "<leader>dl", function () -- duplicate line
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     print(cursor_pos)
--     vim.cmd("normal! yyp")
--     vim.api.nvim_win_set_cursor(0, {cursor_pos[1] + 1, cursor_pos[2]})
-- end) -- duplicate line and cursor stays
-- ----------------------------------------
--
-- ----------------------------------------
-- map("n", "<leader>lr", ":Telescope lsp_references<CR>", common) -- telescope lsp references [space]lr
-- map("n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", common) -- code action with [space]la
-- map("n", "<leader>ld", ":Telescope diagnostics<CR>", common) -- diagnostics use Ctrl+q to spawn quickfix buffer
-- map("n", "<leader>lf", ":set foldmethod=expr<CR>", common) -- activate fold to the current buffer and toggle with za
-- map("n", "<leader>lfb", ":lua vim.lsp.buf.format()<CR>", common) -- format code
-- map("n", "<leader>lqf", ":lua vim.diagnostic.setqflist()<CR>", common) -- quickfix list
-- ----------------------------------------
--
-- ----------------------------------------
-- map("n", "<leader>ff", ":Telescope find_files<CR>", common) -- telescope with cwd
-- map("n", "<leader>fr", ":Telescope oldfiles<CR>", common) -- telescope with oldfiles
-- map("n", "<leader>fp", ":Telescope git_files<CR>", common) -- telescope with git files
-- map("n", "<leader>f", ":Ex<CR>", common) -- open netrw with [space]+f
-- ----------------------------------------
--
-- ----------------------------------------
-- vim.keymap.set("n", "<leader>cC", function () nvim_cc.input_compile_command() end) -- compile command input
-- vim.keymap.set("n", "<leader>cc", function ()
--     if Nvim_cc_term_buffn == nil or vim.fn.bufexists(Nvim_cc_term_buffn) ~= 1 then
--         nvim_cc.run_compile_command()
--     else
--         vim.api.nvim_buf_delete(Nvim_cc_term_buffn, { force = true })
--         nvim_cc.run_compile_command()
--     end
-- end) -- run compile command
-- vim.keymap.set("n", "<leader>cd", function () nvim_cc.run_compile_command_silent() end) -- compile command default or silent
-- vim.keymap.set("n", "<leader>cf", function () nvim_cc.set_compile_command_from_file() end) -- set compile command from file
-- vim.keymap.set("n", "<leader>cs", function () -- sync file dir to current dir and do <leader>cf auto
--     nvim_cc.sync_directory_to_buffer()
--     nvim_cc.set_compile_command_from_file()
--     print("cwd & cc set.")
-- end)
-- vim.keymap.set("n", "<leader>cw", function () nvim_cc.export_compile_command() end) -- export compile command
-- vim.keymap.set("n", "<leader>cj", function () nvim_cc.jump_to_error_position() end) -- jump compile command
--
-- ----------------------------------------
--
-- ----------------------------------------
-- map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], common) -- subtitute word with [space]+s
-- map("n", "<leader>sw", "<cmd>normal! *<CR>", common) -- search text with [space]+sw
-- map("n", "<leader>sb", "<cmd>normal! #<CR>", common) -- search text with [space]+sb
-- map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], common) -- subtitute word with [space]+ss with choice
-- map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", common) -- search vim help [space]+sh
-- vim.keymap.set("n", "<leader>fs", function()
--     local builtin = require("telescope.builtin")
--     builtin.grep_string({search = vim.fn.input("Find String : ")}) -- findout some text on the working dir using [space]+f+s
-- end)
-- ----------------------------------------
--
-- ----------------------------------------
-- map("n", "<leader>be", [[:tabe <CR>]], {}) -- new empty buffer tab (tmp)
-- map("n", "<leader>bn", ":bNext<CR>", common) -- [space] + b + n to go to the next buffer
-- map("n", "<leader>bp", ":bprev<CR>", common) -- [space] + b + p to go to the next buffer
-- map("n", "<leader>bl", ":Telescope buffers<CR>", common) -- [space] + b + b to spawn telescope that show opened buffer
-- map("n", "<leader>bs", ":vsp | Telescope buffers<CR>", common) -- select buffer then do vertical split
-- map("n", "<leader>bc", ":bd!<CR>", common) -- remove / delete buffer
-- map("n", "<leader>br", ":e<CR>", common) -- remove / delete buffer
-- ----------------------------------------
--
-- ----------------------------------------
-- map("n", "<leader>jj", "<cmd>normal! %<CR>", common) -- jump parent
-- map("n", "<leader>jh", "<cmd>normal! ^<CR>", common) -- jump first
-- map("n", "<leader>jl", "<cmd>normal! $<CR>", common) -- jump last
-- map("v", "<leader>jj", "<cmd>normal! %<CR>", common) -- jump parent
-- map("v", "<leader>jh", "<cmd>normal! ^<CR>", common) -- jump first
-- map("v", "<leader>jl", "<cmd>normal! $<CR>", common) -- jump last
-- ----------------------------------------

local wk = require("which-key")

wk.add({
  { "<leader>", group = "Leader" },
  { "<leader>y", "\"+y", desc = "Yank/Copy to System Clipboard", mode = "v" },
  { "<leader>nt", ":tabe .<CR>", desc = "Open New Tab", mode = "n" },
  { "<leader>h", ":tab Alpha<CR>", desc = "Open Home (Alpha)", mode = "n" },
  { "<leader><Esc>", "<C-\\><C-n>", desc = "Exit Terminal Mode", mode = "t", hidden = true },
  { "<Esc>", ":noh<CR>", desc = "Clear Search Highlight", mode = "n", hidden = true },
  { "<C-j>", ":m '>+1<CR>gv=gv", desc = "Move Selection Down", mode = "v" },
  { "<C-k>", ":m '<-2<CR>gv=gv", desc = "Move Selection Up", mode = "v" },
  { "<C-j>", ":m .+1<CR>==", desc = "Move Line Down", mode = "n" },
  { "<C-k>", ":m .-2<CR>==", desc = "Move Line Up", mode = "n" },
  { "<leader>jj", "<cmd>normal! %<CR>", desc = "Jump Matching Parenthesis", mode = { "n", "v" } },
  { "<leader>jh", "<cmd>normal! ^<CR>", desc = "Jump to Line Start", mode = { "n", "v" } },
  { "<leader>jl", "<cmd>normal! $<CR>", desc = "Jump to Line End", mode = { "n", "v" } },
  { "<leader><leader>x", "<cmd>source %<CR>", desc = "Source Current File (Lua)", mode = "n" },
  { "<leader>pc", "<cmd>CccPick<CR>", desc = "Color Picker", mode = "n" },
  { "<leader>ut", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree", mode = "n" },

  { "<leader>dl", function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      print(cursor_pos)
      vim.cmd("normal! yyp")
      vim.api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, cursor_pos[2] })
    end,
    desc = "Duplicate Line with Cursor",
    mode = "n",
  },

  { "<leader>gs", ":Git<CR>", desc = "Git Status", mode = "n" },
  { "<leader>gsd", ":Git diff<CR>", desc = "Git Diff", mode = "n" },
  { "<leader>gp", ":Git push<CR>", desc = "Git Push", mode = "n" },

  { "<leader>ff", ":Telescope find_files<CR>", desc = "Find Files", mode = "n" },
  { "<leader>fr", ":Telescope oldfiles<CR>", desc = "Recent Files", mode = "n" },
  { "<leader>fp", ":Telescope git_files<CR>", desc = "Git Files", mode = "n" },
  { "<leader>f", ":Oil<CR>", desc = "Open Netrw", mode = "n" },
  { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags", mode = "n" },
  { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Substitute Word Globally", mode = "n" },
  { "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], desc = "Substitute Word Globally (With Choice)", mode = "n" },
  { "<leader>sw", "<cmd>normal! *<CR>", desc = "Search Word Forward", mode = "n" },
  { "<leader>sb", "<cmd>normal! #<CR>", desc = "Search Word Backward", mode = "n" },
  { "<leader>fs", function()
      require("telescope.builtin").grep_string({ search = vim.fn.input("Find String : ") })
    end,
    desc = "Search String",
    mode = "n",
  },

  { "<leader>be", [[:tabe <CR>]], desc = "New Empty Buffer Tab", mode = "n" },
  { "<leader>bn", ":bNext<CR>", desc = "Next Buffer", mode = "n" },
  { "<leader>bp", ":bprev<CR>", desc = "Previous Buffer", mode = "n" },
  { "<leader>bl", ":Telescope buffers<CR>", desc = "List Buffers", mode = "n" },
  { "<leader>bs", ":vsp | Telescope buffers<CR>", desc = "Vertical Split and Select Buffer", mode = "n" },
  { "<leader>bc", ":bd!<CR>", desc = "Delete Buffer", mode = "n" },
  { "<leader>br", ":e<CR>", desc = "Reload Buffer", mode = "n" },

  { "<leader>lr", ":Telescope lsp_references<CR>", desc = "LSP References", mode = "n" },
  { "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code Action", mode = "n" },
  { "<leader>ld", ":Telescope diagnostics<CR>", desc = "Diagnostics", mode = "n" },
  { "<leader>lf", ":set foldmethod=expr<CR>", desc = "Activate Folding", mode = "n" },
  { "<leader>lfb", ":lua vim.lsp.buf.format()<CR>", desc = "Format Code", mode = "n" },
  { "<leader>lqf", ":lua vim.diagnostic.setqflist()<CR>", desc = "Quickfix List", mode = "n" },

  { "<leader>cC", function() nvim_cc.input_compile_command() end, desc = "Input Compile Command", mode = "n" },
  { "<leader>cc", function()
      if Nvim_cc_term_buffn == nil or vim.fn.bufexists(Nvim_cc_term_buffn) ~= 1 then
        nvim_cc.run_compile_command()
      else
        vim.api.nvim_buf_delete(Nvim_cc_term_buffn, { force = true })
        nvim_cc.run_compile_command()
      end
    end,
    desc = "Run Compile Command",
    mode = "n",
  },
  { "<leader>cf", function() nvim_cc.set_compile_command_from_file() end, desc = "Set Compile Command From File", mode = "n" },
  { "<leader>cs", function()
      nvim_cc.sync_directory_to_buffer()
      nvim_cc.set_compile_command_from_file()
      print("cwd & cc set.")
    end,
    desc = "Sync Directory & Set Compile Command",
    mode = "n",
  },
  { "<leader>cw", function() nvim_cc.export_compile_command() end, desc = "Export Compile Command", mode = "n" },
  { "<leader>cj", function() nvim_cc.jump_to_error_position() end, desc = "Jump to Error Position", mode = "n" },

  -- { "mf", ":normal mf<CR>", desc = "Mark File (netrw)", mode = "v" },
})
