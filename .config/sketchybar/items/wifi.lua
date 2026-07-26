local colors = require("colors")

local wifi = sbar.add("item", "wifi", {
  position = "right",
  icon = { string = "Wi-Fi" },
  update_freq = 10,
})

wifi:subscribe("routine", function()
  sbar.exec("route -n get default 2>/dev/null", function(info, exit_code)
    local online = exit_code == 0 and (info or ""):find("interface: en") ~= nil
    wifi:set({
      icon = { color = online and colors.text or colors.muted },
      label = { string = online and "On" or "Off" },
    })
  end)
end)
