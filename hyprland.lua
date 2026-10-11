-- Macchiato Nocturne: mauve -> blue gradient, quiet surface borders
local active_border_color = { colors = { "rgba(c6a0f6ff)", "rgba(8aadf4ff)" }, angle = 45 }

hl.config({
  general = {
    border_size = 2,
    col = {
      active_border = active_border_color,
      inactive_border = "rgba(494d64aa)",
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = "rgba(494d6480)",
    },
  },

  decoration = {
    rounding = 12,

    shadow = {
      enabled = true,
      range = 20,
      render_power = 3,
      color = "rgba(181926ee)",
    },

    blur = {
      enabled = true,
      size = 8,
      passes = 3,
      noise = 0.02,
      contrast = 1.0,
      brightness = 0.9,
      vibrancy = 0.2,
      vibrancy_darkness = 0.5,
    },
  },

  cursor = {
    sync_gsettings_theme = true,
  },
})

-- Workspace switching: smooth slide + fade
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slidefadeforwards" })

-- Window open/close animations
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "easeOutQuint", style = "popin 85%" })

-- Fade animations for smooth transitions
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "quick" })

-- Layer animations (panels, bars)
hl.animation({ leaf = "layers", enabled = true, speed = 3.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "linear", style = "fade" })

-- Border animation
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "easeOutQuint" })
