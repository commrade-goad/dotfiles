local custom_color = {
    base00 = '#1e1714', base01 = '#372924', base02 = '#4f3c35', base03 = '#684f45',
    base04 = '#a17f72', base05 = '#eae3e0', base06 = '#be9369', base07 = '#cd7b59',
    base08 = '#cd7b59', base09 = '#ab753f', base0A = '#69be93', base0B = '#93be69',
    base0C = '#6993be', base0D = '#9369be', base0E = '#3f75ab', base0F = '#d2c2bb'
}

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#ab3f75" })

function Reapply_color()
    require('base16-colorscheme').setup(custom_color)
end

return custom_color
