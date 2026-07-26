#!/bin/bash

wifi=(
    label.font="$FONT:Bold:10.0"
    update_freq=30
    script="$PLUGIN_DIR/wifi.sh"
    popup.align=center
    popup.height=28
)

wifi_status=(
    icon="􀤆 "
    label="Checking connection…"
    click_script="open 'x-apple.systempreferences:com.apple.wifi-settings-extension'; sketchybar --set wifi popup.drawing=off"
)

wifi_ip=(
    icon="􀆪 "
    label="IP: unavailable"
    click_script="open 'x-apple.systempreferences:com.apple.wifi-settings-extension'; sketchybar --set wifi popup.drawing=off"
)

wifi_settings=(
    icon="􀍟 "
    label="Open Wi-Fi Settings…"
    click_script="open 'x-apple.systempreferences:com.apple.wifi-settings-extension'; sketchybar --set wifi popup.drawing=off"
)

sketchybar --add item wifi right \
           --set wifi "${wifi[@]}" \
           --subscribe wifi wifi_change mouse.clicked system_woke \
           \
           --add item wifi.status popup.wifi \
           --set wifi.status "${wifi_status[@]}" \
           \
           --add item wifi.ip popup.wifi \
           --set wifi.ip "${wifi_ip[@]}" \
           \
           --add item wifi.settings popup.wifi \
           --set wifi.settings "${wifi_settings[@]}"
