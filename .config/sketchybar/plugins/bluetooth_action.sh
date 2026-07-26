#!/bin/bash

ACTION="${1:-}"
VALUE="${2:-}"

case "$ACTION" in
    power)
        blueutil --power toggle >/dev/null 2>&1
        ;;
    device)
        [[ "$VALUE" =~ ^([[:xdigit:]]{2}[:-]){5}[[:xdigit:]]{2}$ ]] || exit 1
        if [[ "$(blueutil --is-connected "$VALUE" 2>/dev/null)" == "1" ]]; then
            blueutil --disconnect "$VALUE" >/dev/null 2>&1
        else
            blueutil --connect "$VALUE" >/dev/null 2>&1
        fi
        ;;
    *)
        exit 1
        ;;
esac

sketchybar --set bluetooth popup.drawing=off
sketchybar --trigger bluetooth_change
sleep 2
sketchybar --trigger bluetooth_change
sketchybar --trigger audio_device_change
