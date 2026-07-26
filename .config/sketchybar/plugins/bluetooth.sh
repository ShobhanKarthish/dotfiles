#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PLUGIN_DIR="$CONFIG_DIR/plugins"
BLUETOOTH_SETTINGS="x-apple.systempreferences:com.apple.BluetoothSettings"

update() {
    local power connected_count color label

    power="$(blueutil --power 2>/dev/null)"
    connected_count="$(blueutil --connected --format json 2>/dev/null | jq -r 'length' 2>/dev/null)"
    [[ "$connected_count" =~ ^[0-9]+$ ]] || connected_count=0

    color="$WHITE"
    label=""
    if [[ "$power" != "1" ]]; then
        color="$GREY"
    elif (( connected_count > 0 )); then
        color="$BLUE"
        label="$connected_count"
    fi

    sketchybar --set bluetooth icon.color="$color" label="$label"
}

build_popup() {
    local power paired_count index address device connected marker power_label click_command

    power="$(blueutil --power 2>/dev/null)"
    if [[ "$power" == "1" ]]; then
        power_label="Bluetooth: On"
    else
        power_label="Bluetooth: Off"
    fi

    sketchybar --remove '/bluetooth\.popup\..*/' >/dev/null 2>&1

    sketchybar --add item bluetooth.popup.power popup.bluetooth \
               --set bluetooth.popup.power icon=" " \
                                           icon.color="$BLUE" \
                                           label="$power_label" \
                                           click_script="$PLUGIN_DIR/bluetooth_action.sh power"

    index=0
    while IFS=$'\t' read -r address device connected; do
        [[ -z "$address" || -z "$device" ]] && continue
        index=$((index + 1))
        marker="○"
        [[ "$connected" == "true" ]] && marker="✓"
        click_command="$PLUGIN_DIR/bluetooth_action.sh device $address"

        sketchybar --add item "bluetooth.popup.device.$index" popup.bluetooth \
                   --set "bluetooth.popup.device.$index" icon="$marker" \
                                                           icon.color="$BLUE" \
                                                           label="$device" \
                                                           label.max_chars=28 \
                                                           click_script="$click_command"
    done < <(blueutil --paired --format json 2>/dev/null | jq -r '.[] | [.address, .name, (.connected | tostring)] | @tsv')

    paired_count="$index"
    if (( paired_count == 0 )); then
        sketchybar --add item bluetooth.popup.empty popup.bluetooth \
                   --set bluetooth.popup.empty icon="—" \
                                               icon.color="$GREY" \
                                               label="No paired devices" \
                                               label.color="$GREY"
    fi

    sketchybar --add item bluetooth.popup.settings popup.bluetooth \
               --set bluetooth.popup.settings icon="􀍟 " \
                                               label="Open Bluetooth Settings…" \
                                               click_script="open '$BLUETOOTH_SETTINGS'; sketchybar --set bluetooth popup.drawing=off"
}

mouse_clicked() {
    if [[ "${BUTTON:-left}" == "right" ]]; then
        open "$BLUETOOTH_SETTINGS"
        sketchybar --set bluetooth popup.drawing=off
        return
    fi

    build_popup
    sketchybar --set bluetooth popup.drawing=toggle
}

case "$SENDER" in
    mouse.clicked) mouse_clicked ;;
    *) update ;;
esac
