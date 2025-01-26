local wezterm = require 'wezterm'

return {
  -- Aparência e configurações gerais
  --color_scheme = 'Ef-Elea-Light',
  color_scheme = 'Gruvbox Dark (Gogh)',
  enable_tab_bar = true,
  font_size = 14.0,
  font = wezterm.font('JetBrains Mono'),
--  macos_window_background_blur = 30,
  -- window_background_image = '/Users/toor/Downloads/fundo.jpg',
--  window_background_image_hsb = {
 --   brightness = 0.199,
  --  hue = 1.0,
  --  saturation = 0.8,
 -- },
 -- window_background_opacity = 1.0,
  window_decorations = 'RESIZE',

  -- Configurações de atalhos
  keys = {
    -- Alternar para tela cheia
    { key = 'f', mods = 'CTRL', action = wezterm.action.ToggleFullScreen },

    -- Divisão vertical (lado a lado)
    { key = 'D', mods = 'CMD', action = wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"} },

    -- Divisão horizontal (acima/abaixo)
    { key = 'E', mods = 'CMD', action = wezterm.action.SplitVertical{domain="CurrentPaneDomain"} },

    -- Navegação entre divisões usando Command + setas
    { key = 'LeftArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection("Left") },
    { key = 'RightArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection("Right") },
    { key = 'UpArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection("Up") },
    { key = 'DownArrow', mods = 'CMD', action = wezterm.action.ActivatePaneDirection("Down") },
  },

  -- Configurações do mouse
  mouse_bindings = {
    -- Ctrl-click abre o link sob o cursor
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}

