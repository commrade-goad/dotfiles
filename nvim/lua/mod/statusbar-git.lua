M = {}
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

function M.get_git_changes(_, buffer)
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

function M.get_git_branch(_, buffer)
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

return M
