local Job = require "plenary.job"

local git_insertions = vim.regex [[\(\d\+\)\( insertions\)\@=]]
local git_changed = vim.regex [[\(\d\+\)\( file changed\)\@=]]
local git_deletions = vim.regex [[\(\d\+\)\( deletions\)\@=]]

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

    return string.format("[%s]", table.concat(result, ", "))
end

local function get_git_changes(_, buffer)
    if
        vim.api.nvim_buf_get_option(buffer.bufnr, "bufhidden") ~= ""
        or vim.api.nvim_buf_get_option(buffer.bufnr, "buftype") == "nofile"
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
        ["errors"] = { "E", "DiagnosticError" },
        ["warnings"] = { "W", "DiagnosticWarn" },
        ["infos"] = { "I", "DiagnosticInfo" },
        ["hints"] = { "H", "DiagnosticHint" },
    }
    for _, k in ipairs({ "errors", "warnings", "infos", "hints" }) do
        if counts[k] > 0 then
            -- table.insert(items, set_hl(icons[k][2], (" %s%s "):format(icons[k][1], counts[k])))
            table.insert(items, ("%s%s"):format(icons[k][1], counts[k]))
        end
    end
    local fmt = "%s"
    if vim.tbl_isempty(items) then
        return ""
    end
    -- local contents = ("%s"):format(table.concat(items, ""))
    local contents = ("%s"):format(table.concat(items, "|"))
    local final = "|" .. fmt:format(contents) .. "|"
    return final
end

local function mode(_, _)
    local modes = {
        n = { "Normal", { "StatusLine" } },
        niI = { "Normal", { "StatusLine" } },
        niR = { "Normal", { "StatusLine" } },
        niV = { "Normal", { "StatusLine" } },
        no = { "N·OpPd", { "StatusLine" } },
        v = { "Visual", { "Directory" } },
        V = { "V·Line", { "Directory" } },
        ['\22'] = { "V·Blck", { "Directory" } },
        s = { "Select", { "Search" } },
        S = { "S·Line", { "Search" } },
        ['\19'] = { "S·Block", { "Search" } },
        i = { "Insert", { "DiffText" } },
        ic = { "ICompl" },
        R = { "Rplace", { "WarningMsg", "IncSearch" } },
        Rv = { "VRplce", { "WarningMsg", "IncSearch" } },
        c = { "Cmmand", { "diffAdded", "DiffAdd" } },
        cv = { "Vim Ex" },
        ce = { "Ex (r)" },
        r = { "Prompt" },
        rm = { "More  " },
        ["r?"] = { "Cnfirm" },
        ["!"] = { "Shell ", { "DiffAdd", "diffAdded" } },
        nt = { "Term  ", { "Visual" } },
        t = { "Term  ", { "DiffAdd", "diffAdded" } },
    }
    local fmt = " %s "
    local m = vim.api.nvim_get_mode().mode
    local mode_data = modes and modes[m]
    local hls = mode_data and mode_data[2]
    m = mode_data and mode_data[1]:upper() or m
    m = (fmt):format(m)
    return set_hl(hls, m) or m
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

local excluded_filetypes = { "alpha", "undotree", "help", "TelescopePrompt", "TelescopeResults" }
local mres = mode()
local diag = diagnostics(0)
local status = false
local branch = ""
local change = ""
local sl = mres .. " %f %m" .. diag ..  "%=" .. change .. branch .. "%y %l:%c "

local function update_display()
    if status then
        vim.o.statusline = ""
        vim.opt.laststatus = 0
    else
        vim.opt.laststatus = 3
        sl = mres .. " %f %m" .. diag ..  "%=" .. change .. branch .. "%y %l:%c "
        vim.o.statusline = sl
    end
    vim.defer_fn(update_display, 250)
end

local function check_buffer()
    local filetype = vim.bo.filetype
    local exclude = false
    for _, ft in ipairs(excluded_filetypes) do
        if filetype == ft then
            exclude = true
            break
        end
    end
    status = exclude
    vim.defer_fn(check_buffer, 500)
end

local function update_diagnostic()
    diag = diagnostics(vim.api.nvim_get_current_buf())
    vim.defer_fn(update_diagnostic, 1000)
end

local function update_mode()
    mres = mode();
    vim.defer_fn(update_mode, 250)
end

local function setup_gitb()
    vim.api.nvim_create_autocmd({"VimEnter", "BufWinEnter"}, {
        callback = function ()
            local curbuff = vim.api.nvim_get_current_buf()
            local curbuffname = vim.api.nvim_buf_get_name(curbuff)
            local lb = get_git_branch(nil, curbuffname)
            if lb then
                branch = "[" .. lb .. "]"
            else
                branch = ""
            end
        end
    })
end

local function setup_gitc()
    vim.api.nvim_create_autocmd({"VimEnter", "BufWritePost", "BufWinEnter"}, {
        callback = function ()
            local curbuff = vim.api.nvim_get_current_buf()
            local curbuffname = vim.api.nvim_buf_get_name(curbuff)
            local lb = get_git_changes(nil, {name = curbuffname, bufnr = curbuff})
            if lb then
                change = lb
            else
                change = ""
            end
        end
    })
end

setup_gitb()
setup_gitc()
vim.api.nvim_create_autocmd({"VimEnter", "BufEnter"}, {
    pattern = "*",
    callback = function ()
        check_buffer()
        update_mode()
        update_diagnostic()
        update_display()
    end
})
