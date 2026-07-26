local colors = require("colors")

for sid = 1, 9 do
  local space = sbar.add("space", "space." .. sid, {
    position = "left",
    associated_space = sid,
    icon = {
      string = tostring(sid),
      color = colors.muted,
      padding_left = 9,
      padding_right = 9,
    },
    label = { drawing = false },
    background = { color = colors.surface },
  })

  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    space:set({
      icon = { color = selected and colors.bg or colors.muted },
      background = { color = selected and colors.accent or colors.surface },
    })
  end)

  space:subscribe("mouse.clicked", function()
    sbar.exec("yabai -m space --focus " .. sid)
  end)
end
