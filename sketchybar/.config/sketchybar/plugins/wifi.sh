#!/usr/bin/env sh

if route -n get default 2>/dev/null | grep -q 'interface: en'; then
  sketchybar --set "$NAME" icon.color=0xffe6e9ef label="On"
else
  sketchybar --set "$NAME" icon.color=0xff8b93a7 label="Off"
fi
