local my_colorscheme = {
    base00 = '#%bgcolor%', -- background color
    base01 = '#%t_surface%', -- current line color and the bar color
    base02 = '#%t_d_black%', -- visual mode color
    base03 = '#%t_b_black%', -- comment and newline icon
    base04 = '#%t_fgcolor_dim%',
    base05 = '#%fgcolor%', -- normal text color
    base06 = '#%t_n_yellow%',
    base07 = '#%t_cur_color%',
    base08 = '#%t_n_red%',
    base09 = '#%t_d_yellow%',
    base0A = '#%t_n_cyan%',
    base0B = '#%t_n_green%',
    base0C = '#%t_n_blue%',
    base0D = '#%t_n_magenta%',
    base0E = '#%t_d_blue%',
    base0F = '#%t_b_black%' -- delimiter
}

function Reapply_color()
    require('base16-colorscheme').setup(my_colorscheme)
end

return my_colorscheme
