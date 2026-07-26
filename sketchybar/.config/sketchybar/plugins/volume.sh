#!/usr/bin/env sh

VOLUME=${INFO:-$(osascript -e 'output volume of (get volume settings)' 2>/dev/null)}
if [ "${VOLUME:-0}" -eq 0 ]; then ICON="Mute"; else ICON="Vol"; fi
sketchybar --set "$NAME" icon="$ICON" label="${VOLUME:-0}%"
