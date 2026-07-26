local colors = require("colors")
local settings = require("settings")

sbar.bar({
  position = "top",
  height = settings.height,
  color = colors.bg,
  shadow = false,
  sticky = true,
  topmost = true,
  padding_left = 8,
  padding_right = 8,
  margin = 6,
  y_offset = 3,
  corner_radius = 9,
})
