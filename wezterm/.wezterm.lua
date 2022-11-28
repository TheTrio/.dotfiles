local wezterm = require 'wezterm'

return {
    font = wezterm.font('JetBrains Mono'),
    default_prog = { '/usr/bin/fish', '-l' },

    colors = {
        cursor_bg = '#E84A72',
        foreground = '#BABABA',
        background = '#16161C',
        ansi = {
            '#131419',
            '#E95678',
            '#29D398',
            '#FAB795',
            '#26BBD9',
            '#EE64AE',
            '#59E3E3',
            '#C7C7C7',
        },
        brights = {
            '#676767',
            '#EC6A88',
            '#3FDAA4',
            '#FBC3A7',
            '#3FC6DE',
            '#F075B7',
            '#6BE6E6',
            '#FEFFFF',
        },
    },
    hide_tab_bar_if_only_one_tab = true,
    window_background_opacity = 0.95,
    animation_fps = 20,
    default_cursor_style = 'SteadyBlock',
    enable_wayland = true,
}
