local Job = require "plenary.job"

local git_insertions = vim.regex [[\(\d\+\)\( insertions\)\@=]]
local git_changed = vim.regex [[\(\d\+\)\( file changed\)\@=]]
local git_deletions = vim.regex [[\(\d\+\)\( deletions\)\@=]]

-- CUSTOM COLOR FOR DIAGNOSTIC
local errormsg_hl = vim.api.nvim_get_hl(0, {name="ErrorMsg"})
local default_hl = vim.api.nvim_get_hl(0, {name="Default"})
local warningmsg_hl = vim.api.nvim_get_hl(0, {name="WarningMsg"})
local statusline_hl = vim.api.nvim_get_hl(0, {name="StatusLine"})

vim.api.nvim_set_hl(0, "ErrorDiagnostics", {
    fg = errormsg_hl.bg,
    bg = statusline_hl.bg,
    bold = true,
    italic = false
})

vim.api.nvim_set_hl(0, "WarningDiagnostics", {
    fg = warningmsg_hl.bg,
    bg = statusline_hl.bg,
    bold = true,
    italic = false
})

vim.api.nvim_set_hl(0, "InfoDiagnostics", {
    fg = default_hl.fg,
    bg = statusline_hl.bg,
    bold = true,
    italic = false
})

local function parse_shortstat_output(s)
    local result = {}

    local insert = { git_insertions:match_str(s) }
    if not vim.tbl_isempty(insert) then
        table.insert(result, string.format("+%s", string.sub(s, insert[1] + 1, insert[2])))
    end

    local changed = { git_changed:match_str(s) }
    if not vim.tbl_isempty(changed) then
        table.insert(result, string.format("~%s", string.sub(s, changed[1] + 1, changed[2])))
    end

    local delete = { git_deletions:match_str(s) }
    if not vim.tbl_isempty(delete) then
        table.insert(result, string.format("-%s", string.sub(s, delete[1] + 1, delete[2])))
    end

    if vim.tbl_isempty(result) then
        return nil
    end

    return string.format("(%s)", table.concat(result, ", "))
end

local function get_git_changes(_, buffer)
    if
        vim.api.nvim_get_option_value("bufhidden", {buf=buffer.bufnr}) ~= "" or
        vim.api.nvim_get_option_value("buftype", {buf=buffer.bufnr}) == "nofile"
    then
        return
    end

    if vim.fn.filereadable(buffer.name) ~= 1 then
        return
    end

    local j = Job:new {
        command = "git",
        args = { "diff", "--shortstat", buffer.name },
        cwd = vim.fn.fnamemodify(buffer.name, ":h"),
    }

    local ok, result = pcall(function()
        return parse_shortstat_output(vim.trim(j:sync()[1]))
    end)

    if ok then
        return result
    else
        return ""
    end
end

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
        ["errors"] = { "E", "ErrorDiagnostics" },
        ["warnings"] = { "W", "WarningDiagnostics" },
        ["infos"] = { "I", "InfoDiagnostics" },
        ["hints"] = { "H", "InfoDiagnostics" },
    }
    for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
        if counts[k] > 0 then
            table.insert(items, set_hl(icons[k][2], ("%s%s"):format(icons[k][1], counts[k])))
        end
    end
    local fmt = "%s"
    if vim.tbl_isempty(items) then
        return ""
    end
    -- local contents = ("%s"):format(table.concat(items, ""))
    local contents = ("%s"):format(table.concat(items, ":"))
    local final = "[" .. fmt:format(contents) .. "]"
    return final
end

local function get_git_branch(_, buffer)
    local j = Job:new {
        command = "git",
        args = { "branch", "--show-current" },
        cwd = vim.fn.fnamemodify(buffer.name, ":h"),
    }

    local ok, result = pcall(function()
        return vim.trim(j:sync()[1])
    end)

    if ok then
        return result
    end
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

local excluded_filetypes = { "alpha", "undotree", "fugitive" }
local diag = ""
local branch = ""
local change = ""
local nlmode = ""
vim.o.statusline = ""
vim.opt.laststatus = 0

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
    vim.o.statusline = " %f %r%m" .. diag .. branch .. "%=" .. change .. " " ..  nlmode .. "%y %l:%c "
end

local function get_buffer_nl()
    local ff = vim.o.fileformat
    if ff == "unix" or ff == "mac" then
        return "[LF]"
    else
        return "[CRLF]"
    end
end

local function setup_gitb()
    vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "BufWinEnter"}, {
        group = vim.api.nvim_create_augroup("statubar_gitb", {clear = true}),
        callback = function ()
            local curbuff = vim.api.nvim_get_current_buf()
            local curbuffname = vim.api.nvim_buf_get_name(curbuff)
            local lb = get_git_branch(nil, curbuffname)
            if lb then
                branch = "(" .. lb .. ")"
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
            local lb = get_git_changes(nil, {name = curbuffname, bufnr = curbuff}) if lb then
                change = lb
            else
                change = ""
            end
        end
    })
end

local function setup_buffernl()
    -- add `BufWritePost` to make it change the newline mode automatically with
    -- out reloading the buffer. Using this settings make it more heavy for no
    -- reason at all so i dont include that.
    vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "BufWinEnter"}, {
        group = vim.api.nvim_create_augroup("statubar_nline", {clear = true}),
        callback = function ()
            nlmode = get_buffer_nl()
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

setup_gitb()
setup_gitc()
setup_buffernl()
setup_cleanup()

run_looping_task(500, update_display)
