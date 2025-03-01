local my_colorscheme = {
    base00 = '#1e1914', -- background color
    base01 = '#372e24', -- current line color and the bar color
    base02 = '#372e24', -- visual mode color
    base03 = '#685745', -- comment and newline icon
    base04 = '#d2c7bb',
    base05 = '#eae5e0', -- normal text color
    base06 = '#c4a98c',
    base07 = '#c4a98c',
    base08 = '#c48ca7',
    base09 = '#b78c5d',
    base0A = '#8cc4a9',
    base0B = '#a7c48c',
    base0C = '#8ca7c4',
    base0D = '#a98cc4',
    base0E = '#5d88b7',
    base0F = '#685745' -- delimiter
}

function Reapply_color()
    require('base16-colorscheme').setup(my_colorscheme)
end

return my_colorscheme
