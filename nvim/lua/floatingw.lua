local M = {}

function M.get_window_size()
    local window = vim.api.nvim_list_uis()[1]
    return window
end

-- possible value of align : 0 -> left  |  1 -> center  |  2 -> right
function M.create_floating_window_ro(msg, size_w, size_h, position, align)
    local window = {}
    local width, height = size_w, size_h
    if width < 3 then
        local longest = 0
        for i = 1, #msg do
            local c_msg = msg[i]
            if #c_msg > longest then
                longest = #c_msg
            end
        end
        width = longest + 4
    end
    if height <= 3 then
        local counter = 0
        for i = 1, #msg do
            local c_msg = msg[i]
            if #c_msg > width - 2 then
                counter = counter + 1
            end
        end
        height = #msg + 2 + counter
    end
    local new_buff = vim.api.nvim_create_buf(false, true)

    -- the default pos is center
    if position == nil or next(position) == nil then
        window = M.get_window_size()
        window.width = window.width/2 - (width/2)
        window.height = window.height/2 - (height/2)
    else
        window.width = position.w
        window.height = position.h
    end

    local buffer = vim.api.nvim_open_win(new_buff, true, {
        relative="editor",
        width=width,
        height=height,
        col=window.width,
        row=window.height,
        anchor="nw",
        style="minimal"
    })

    local lines = {}
    for _ = 1, height do
        table.insert(lines, string.rep(" ", width))
    end
    vim.api.nvim_buf_set_lines(new_buff, 0, -1, false, lines)

    local offset = 0
    local idx = 1
    while idx <= #msg do
        local c_msg = msg[idx]
        -- truncate string
        if #c_msg > width - 2 then
            table.insert(msg, string.sub(c_msg, width - 1, #c_msg))
            c_msg = string.sub(c_msg, 1, width - 2)
        end
        local start_col = math.floor((width - #c_msg) / 2)
        if align == 0 then
            start_col = 1
        elseif align == 2 then
            start_col = (width - 1) - #c_msg
        end
        local end_col = start_col + #c_msg
        local current_row = math.floor(height / 2 - #msg / 2 + offset)
        offset = offset + 1

        vim.api.nvim_buf_set_text(new_buff, current_row, start_col, current_row, end_col, {c_msg})
        idx = idx + 1
    end

    local close_key = {"<Esc>", "<CR>", "<Leader>", "q"}
    for i = 1, #close_key do
        local c_key = close_key[i]
        vim.api.nvim_buf_set_keymap(new_buff, "n", c_key, ":close<CR>", {silent=true, nowait=true, noremap=true})
    end
    vim.api.nvim_buf_set_option(new_buff, "readonly", true)  -- Prevent saving changes
    vim.api.nvim_buf_set_option(new_buff, "modifiable", false)  -- Prevent any changes
    vim.api.nvim_buf_set_option(new_buff, "buftype", "nofile")  -- Make it a non-file buffer
    vim.api.nvim_buf_set_option(new_buff, "modified", false)  -- Ensure it's not marked as modified
end

function M.create_floating_window(msg, size_w, size_h, position)
    local window = {}
    local width, height = size_w, size_h
    local new_buff = vim.api.nvim_create_buf(false, true)

    -- Default position is center
    if position == nil or next(position) == nil then
        window = M.get_window_size()
        window.width = math.floor(window.width / 2 - width / 2)
        window.height = math.floor(window.height / 2 - height / 2)
    else
        window.width = position.w
        window.height = position.h
    end

    vim.api.nvim_open_win(new_buff, true, {
        relative = "editor",
        width = width,
        height = height,
        col = window.width,
        row = window.height,
        anchor = "nw",
        style = "minimal"
    })

    vim.api.nvim_buf_set_lines(new_buff, 0, -1, false, msg)

    vim.api.nvim_buf_set_option(new_buff, "modifiable", true)  -- Allow modifications
    vim.api.nvim_buf_set_option(new_buff, "readonly", false)   -- Ensure it's not readonly
    vim.api.nvim_buf_set_option(new_buff, "buftype", "nofile") -- Keep it as a non-file buffer
    vim.api.nvim_buf_set_option(new_buff, "modified", true)    -- Mark as modified

    local c_key = "q"
    vim.api.nvim_buf_set_keymap(new_buff, "n", c_key, ":close<CR>", { silent = true, nowait = true, noremap = true })
end

local str = "Hello testing"
M.create_floating_window_ro({str}, 2, 3, nil, 0)
-- M.create_floating_window({str}, #str + 4, 5, nil)

return M
