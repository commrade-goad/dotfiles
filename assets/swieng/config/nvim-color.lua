local custom_color = {
    base00 = '#%bgcolor%', base01 = '#%t_surface%', base02 = '#%t_n_black%', base03 = '#%t_b_black%',
    base04 = '#%t_d_white%', base05 = '#%fgcolor%', base06 = '#%t_n_yellow%', base07 = '#%t_cur_color%',
    base08 = '#%t_n_red%', base09 = '#%t_d_yellow%', base0A = '#%t_n_cyan%', base0B = '#%t_n_green%',
    base0C = '#%t_n_blue%', base0D = '#%t_n_magenta%', base0E = '#%t_d_blue%', base0F = '#%t_b_white%'
}

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#%t_d_red%" })

function Reapply_color()
    require('base16-colorscheme').setup(custom_color)
end

return custom_color
