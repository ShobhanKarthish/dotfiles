#!/bin/bash

DEVICE_ID="${1:-}"
[[ "$DEVICE_ID" =~ ^[0-9]+$ ]] || exit 1

SwitchAudioSource -i "$DEVICE_ID" >/dev/null 2>&1 || exit 1
sketchybar --set volume popup.drawing=off
sketchybar --trigger audio_device_change
