#!/bin/bash

volume=(
    padding_left=10
    icon=" "
    script="$PLUGIN_DIR/volume.sh"
    popup.align=center
    popup.height=30
)

status_bracket=(
    background.color="$BACKGROUND_1"
    background.border_color="$BACKGROUND_2"
)

sketchybar --add event audio_device_change

sketchybar --add item volume right \
           --set volume "${volume[@]}" \
           --subscribe volume volume_change audio_device_change mouse.clicked mouse.scrolled

sketchybar --add bracket status volume battery bluetooth wifi \
           --set status "${status_bracket[@]}"
