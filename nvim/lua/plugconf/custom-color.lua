local custom_color = {
    base00 = '#19141e', base01 = '#2e2437', base02 = '#42354f', base03 = '#574568',
    base04 = '#8a72a1', base05 = '#e5e0ea', base06 = '#c29c72', base07 = '#9c5dd7',
    base08 = '#c27298', base09 = '#b47e42', base0A = '#72c29c', base0B = '#98c272',
    base0C = '#7298c2', base0D = '#9c5dd7', base0E = '#4279b4', base0F = '#c7bbd2'
}

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#b44279" })

function Reapply_color()
    require('base16-colorscheme').setup(custom_color)
end

return custom_color
