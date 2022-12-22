local wezterm = require 'wezterm'

function make_mouse_binding(dir, streak, button, mods, action)
  return {
    event = { [dir] = { streak = streak, button = button } },
    mods = mods,
    action = action,
  }
end

return {
  font = wezterm.font('JetBrains Mono'),
  default_prog = { '/usr/bin/fish', '-l' },
  adjust_window_size_when_changing_font_size = false,
  window_decorations = "NONE",

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
  window_background_opacity = 0.85,
  animation_fps = 20,
  default_cursor_style = 'SteadyBlock',
  enable_wayland = true,

  hyperlink_rules = {
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },

    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = 'mailto:$0',
    },

    {
      regex = [[\bfile://\S*\b]],
      format = '$0',
    },

    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },

    {
      regex = [[\b[tT](\d+)\b]],
      format = 'https://example.com/tasks/?t=$1',
    },

    {
      regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
      format = 'https://www.github.com/$1/$3',
    },
  },

  mouse_bindings = {
    make_mouse_binding('Up', 1, 'Left', 'NONE',
      wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 1, 'Left', 'SHIFT',
      wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 1, 'Left', 'ALT', wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 1, 'Left', 'SHIFT|ALT',
      wezterm.action.CompleteSelectionOrOpenLinkAtMouseCursor 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 2, 'Left', 'NONE', wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'),
    make_mouse_binding('Up', 3, 'Left', 'NONE', wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection'),
  },

  keys = {
    {
      key = 'n',
      mods = 'SHIFT|CTRL',
      action = wezterm.action.SpawnWindow
    },
    {
      key = 'c',
      mods = 'CTRL|ALT',
      action = wezterm.action.SpawnCommandInNewWindow {
        args = { 'code', '.' },
      },
    },
  },
}
