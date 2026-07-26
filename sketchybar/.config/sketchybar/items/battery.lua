local battery = sbar.add("item", "battery", {
  position = "right",
  update_freq = 60,
})

local function update_battery()
  sbar.exec("pmset -g batt", function(info)
    local percentage = tonumber((info or ""):match("(%d+)%%")) or 0
    local charging = (info or ""):find("AC Power", 1, true) ~= nil
    local icon = charging and "⚡" or (percentage <= 20 and "Low" or "Bat")
    battery:set({
      icon = { string = icon },
      label = { string = percentage .. "%" },
    })
  end)
end

battery:subscribe({ "routine", "system_woke", "power_source_change" }, update_battery)
