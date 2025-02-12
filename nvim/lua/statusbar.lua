local sbgit = require("statusbar-git")

local function set_hl(hls, s)
    if not hls or not s then
        return s
    end
    hls = type(hls) == "string" and { hls } or hls
    for _, hl in ipairs(hls) do
        if vim.fn.hlID(hl) > 0 then
            return ("%%#%s#%s%%0*"):format(hl, s)
        end
    end
    return s
end

local function diagnostics(bufn) local counts = { 0, 0, 0, 0 }
    local diags = vim.diagnostic.get(bufn)
    if diags and not vim.tbl_isempty(diags) then
        for _, d in ipairs(diags) do
            if tonumber(d.severity) then
                counts[d.severity] = counts[d.severity] + 1
            end
        end
    end
    counts = {
        errors = counts[1],
        warnings = counts[2],
        infos = counts[3],
        hints = counts[4],
    }
    local items = {}
    local icons = {
        ["errors"] = "E",
        ["warnings"] = "W",
        ["infos"] = "I",
        ["hints"] = "H",
    }
    for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
        if counts[k] > 0 then
            table.insert(items, ("%s%s"):format(icons[k], counts[k]))
        end
    end
    local fmt = "%s"
    if vim.tbl_isempty(items) then
        return ""
    end
    local contents = ("%s"):format(table.concat(items, ":"))
    local final = "[" .. fmt:format(contents) .. "]"
    return final
end

local function run_looping_task(interval_ms, action)
    local timer = vim.uv.new_timer()
    if timer ~= nil then
        timer:start(0, interval_ms, vim.schedule_wrap(function()
            action()
        end))
        return timer
    end
    return nil
end

-- DEFINITION --
local excluded_filetypes = { "undotree", "fugitive" }
local diag = ""
local branch = ""
local change = ""
local mode_s = ""
vim.o.statusline = ""
vim.opt.laststatus = 0
----------------

local function check_buffer()
    local filetype = vim.bo.filetype
    local exclude = false
    for _, ft in ipairs(excluded_filetypes) do
        if filetype == ft then
            exclude = true
            break
        end
    end
    return exclude
end

local function update_display()
    if check_buffer() then
        vim.opt.laststatus = 0
    else
        diag = diagnostics(vim.api.nvim_get_current_buf())
        vim.opt.laststatus = 3
    end
    vim.o.statusline = mode_s .. branch .. " %f%m " .. diag .. "%=" .. change .. " " ..  "%r%y[%l:%c]"
end

local function setup_gitb()
    vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "BufWinEnter"}, {
        group = vim.api.nvim_create_augroup("statubar_gitb", {clear = true}),
        callback = function ()
            local curbuff = vim.api.nvim_get_current_buf()
            local curbuffname = vim.api.nvim_buf_get_name(curbuff)
            local lb = sbgit.get_git_branch(nil, curbuffname)
            if lb then
                branch = " " .. lb .. ":"
            else
                branch = ""
            end
        end
    })
end

local function setup_gitc()
    vim.api.nvim_create_autocmd({"VimEnter", "BufWritePost", "BufEnter", "BufWinEnter"}, {
        group = vim.api.nvim_create_augroup("statubar_gitc", {clear = true}),
        callback = function ()
            local curbuff = vim.api.nvim_get_current_buf()
            local curbuffname = vim.api.nvim_buf_get_name(curbuff)
            local lb = sbgit.get_git_changes(nil, {name = curbuffname, bufnr = curbuff}) if lb then
                change = lb
            else
                change = ""
            end
        end
    })
end

local function setup_cleanup()
    vim.api.nvim_create_autocmd("BufLeave", {
        group = vim.api.nvim_create_augroup("statubar_cleanup", {clear = true}),
        callback = function ()
            nlmode = ""
            diag = ""
            branch = "" -- because it check current cwd this will not change until cwd sync
            change = ""
        end
    })
end

local function getcmode()
    local lookuptbl = {
        ['n']  = "NOR",
        ['no'] = "N-O",
        ['v']  = "VIS",
        ['V']  = "VLn",
        [''] = "VBl",
        ['s']  = "SEL",
        ['S']  = "SLn",
        [''] = "SBl",
        ['i']  = "INS",
        ['ic'] = "I-C",
        ['ix'] = "I-X",
        ['R']  = "REP",
        ['Rc'] = "R-C",
        ['Rv'] = "V-R",
        ['Rx'] = "R-X",
        ['c']  = "CMD",
        ['cv'] = "EX ",
        ['ce'] = "EXM",
        ['r']  = "HIT",
        ['rm'] = "MOR",
        ['r?'] = "C-O",
        ['!']  = "SHE",
        ['t']  = "TER",
    }

    local mode = vim.api.nvim_get_mode().mode
    return set_hl("Normal", string.format("[%s]", lookuptbl[mode] or mode))
end

local function setup_cmode()
    mode_s = getcmode()
    vim.api.nvim_create_autocmd("ModeChanged", {
        group = vim.api.nvim_create_augroup("statusbar_mode", {clear = true}),
        callback = function ()
            mode_s = getcmode()
        end
    })
end

setup_gitb()
setup_gitc()
setup_cleanup()
setup_cmode()

run_looping_task(250, update_display)
