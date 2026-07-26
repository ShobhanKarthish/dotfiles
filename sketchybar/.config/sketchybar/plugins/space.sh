#!/usr/bin/env sh

if [ "$SELECTED" = "true" ]; then
  sketchybar --set "$NAME" icon.color=0xff111318 background.color=0xff89b4fa
else
  sketchybar --set "$NAME" icon.color=0xff8b93a7 background.color=0xff1c2028
fi
