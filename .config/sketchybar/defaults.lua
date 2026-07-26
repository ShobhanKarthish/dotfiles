local colors = require("colors")
local settings = require("settings")

sbar.default({
  updates = "when_shown",
  icon = {
    font = { family = settings.font, style = "Semibold", size = 13.0 },
    color = colors.text,
    padding_left = 8,
    padding_right = 5,
  },
  label = {
    font = { family = settings.font, style = "Medium", size = 12.0 },
    color = colors.text,
    padding_left = 3,
    padding_right = 8,
  },
  background = {
    color = colors.surface,
    corner_radius = settings.corner_radius,
    height = settings.item_height,
  },
})
