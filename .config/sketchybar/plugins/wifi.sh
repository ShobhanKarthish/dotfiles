#!/bin/bash

WIFI_SETTINGS="x-apple.systempreferences:com.apple.wifi-settings-extension"

wifi_interface() {
    networksetup -listallhardwareports 2>/dev/null \
        | awk '/Hardware Port: (Wi-Fi|AirPort)/ { getline; print $2; exit }'
}

current_ssid() {
    local interface="$1"
    local result

    result="$(networksetup -getairportnetwork "$interface" 2>/dev/null)"
    if [[ "$result" != *"not associated"* && "$result" == *": "* ]]; then
        printf '%s' "${result#*: }"
    fi
}

update() {
    local interface ip ssid icon status ip_label

    interface="$(wifi_interface)"
    [[ -z "$interface" ]] && interface="en0"
    ip="$(ipconfig getifaddr "$interface" 2>/dev/null)"
    ssid="$(current_ssid "$interface")"

    icon="􀙈 "
    status="Wi-Fi disconnected"
    ip_label="IP: unavailable"

    if [[ -n "$ip" ]]; then
        icon="􀙇 "
        status="Wi-Fi connected"
        [[ -n "$ssid" ]] && status="Connected to $ssid"
        ip_label="IP: $ip"
    fi

    sketchybar --set wifi icon="$icon" \
                           --set wifi.status label="$status" \
                           --set wifi.ip label="$ip_label"
}

mouse_clicked() {
    if [[ "${BUTTON:-left}" == "right" ]]; then
        open "$WIFI_SETTINGS"
        sketchybar --set wifi popup.drawing=off
        return
    fi

    update
    sketchybar --set wifi popup.drawing=toggle
}

case "$SENDER" in
    mouse.clicked) mouse_clicked ;;
    *) update ;;
esac
