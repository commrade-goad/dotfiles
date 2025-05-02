local custom_color = {
    base00 = '#1E1E1E', -- background
    base01 = '#2E2E2E', -- dim0
    base02 = '#3A3A3A', -- dim3 (selection bg)
    base03 = '#6E6E6E', -- dim7 (comments)
    base04 = '#8A8A8A', -- regular7 (dark fg)
    base05 = '#FFFFFF', -- foreground
    base06 = '#E0E0E0', -- bright0
    base07 = '#FFFFFF', -- bright white or light bg
    base08 = '#C4B0B0', -- regular1 (red)
    base09 = '#D0B8B8', -- bright1 (orange)
    base0A = '#C4C4B0', -- regular3 (yellow)
    base0B = '#B0C4B0', -- regular2 (green)
    base0C = '#B0C4C4', -- regular6 (cyan)
    base0D = '#B0B0C4', -- regular4 (blue)
    base0E = '#C4B0C4', -- regular5 (purple)
    base0F = '#AAAAAA', -- dim1 (brown/fallback)
    -- base0F = '#3A2E2E', -- dim1 (brown/fallback)
}

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#C4B0B0" })

function ReColorMyEditor()
    require('base16-colorscheme').setup(custom_color)
end

return custom_color
