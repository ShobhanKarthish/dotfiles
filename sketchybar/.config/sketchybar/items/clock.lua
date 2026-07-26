local clock = sbar.add("item", "clock", {
  position = "right",
  icon = { drawing = false },
  update_freq = 10,
})

clock:subscribe("routine", function()
  clock:set({ label = { string = os.date("%a %d %b  %H:%M") } })
end)
