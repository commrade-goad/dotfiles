local my_colorscheme = {
    base00 = '#1e1514', -- background color
    base01 = '#372524', -- current line color and the bar color
    base02 = '#372524', -- visual mode color
    base03 = '#684745', -- comment and newline icon
    base04 = '#d2bdbb',
    base05 = '#eae1e0', -- normal text color
    base06 = '#c1a486',
    base07 = '#c18b86',
    base08 = '#c18b86',
    base09 = '#b48557',
    base0A = '#86c1a4',
    base0B = '#a4c186',
    base0C = '#86a4c1',
    base0D = '#a486c1',
    base0E = '#5785b4',
    base0F = '#684745' -- delimiter
}

function Reapply_color()
    require('base16-colorscheme').setup(my_colorscheme)
end

return my_colorscheme
