local colors = require("colors")

local launcher = sbar.add("item", "launcher", {
  position = "left",
  icon = { string = "◉", color = colors.accent },
  label = { drawing = false },
})

launcher:subscribe("mouse.clicked", function()
  sbar.exec("open -a Raycast")
end)
