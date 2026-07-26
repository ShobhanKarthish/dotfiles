#!/bin/bash

bluetooth=(
    icon=" "
    icon.font="$FONT:Regular:14.0"
    update_freq=15
    script="$PLUGIN_DIR/bluetooth.sh"
    popup.align=center
    popup.height=28
)

sketchybar --add event bluetooth_change

sketchybar --add item bluetooth right \
           --set bluetooth "${bluetooth[@]}" \
           --subscribe bluetooth bluetooth_change mouse.clicked system_woke
