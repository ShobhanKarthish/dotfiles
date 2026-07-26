#!/usr/bin/env sh

PERCENTAGE=$(pmset -g batt | grep -Eo '[0-9]+%' | head -1 | tr -d '%')
CHARGING=$(pmset -g batt | grep -c 'AC Power')

if [ "$CHARGING" -eq 1 ]; then
  ICON="⚡"
elif [ "${PERCENTAGE:-0}" -le 20 ]; then
  ICON="Low"
else
  ICON="Bat"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE:-?}%"
