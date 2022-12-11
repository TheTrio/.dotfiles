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
  hyperlink_rules = {
    -- Linkify things that look like URLs and the host has a TLD name.
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = '\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b',
      format = '$0',
    },

    -- linkify email addresses
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = 'mailto:$0',
    },

    -- file:// URI
    -- Compiled-in default. Used if you don't specify any hyperlink_rules.
    {
      regex = [[\bfile://\S*\b]],
      format = '$0',
    },

    -- Linkify things that look like URLs with numeric addresses as hosts.
    -- E.g. http://127.0.0.1:8000 for a local development server,
    -- or http://192.168.1.1 for the web interface of many routers.
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },

    -- Make task numbers clickable
    -- The first matched regex group is captured in $1.
    {
      regex = [[\b[tT](\d+)\b]],
      format = 'https://example.com/tasks/?t=$1',
    },

    -- Make username/project paths clickable. This implies paths like the following are for GitHub.
    -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
    -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
    -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
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
}