local volume = sbar.add("item", "volume", {
  position = "right",
  icon = { string = "Vol" },
})

volume:subscribe("volume_change", function(env)
  local level = tonumber(env.INFO) or 0
  volume:set({
    icon = { string = level == 0 and "Mute" or "Vol" },
    label = { string = level .. "%" },
  })
end)
