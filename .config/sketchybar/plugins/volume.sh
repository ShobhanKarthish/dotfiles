#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PLUGIN_DIR="$CONFIG_DIR/plugins"
SOUND_SETTINGS="x-apple.systempreferences:com.apple.Sound-Settings.extension"

current_volume() {
    osascript -e 'output volume of (get volume settings)' 2>/dev/null
}

current_output() {
    SwitchAudioSource -c -t output 2>/dev/null
}

update() {
    local volume muted icon

    volume="$(current_volume)"
    [[ "$volume" =~ ^[0-9]+$ ]] || volume=0
    muted="$(osascript -e 'output muted of (get volume settings)' 2>/dev/null)"

    if [[ "$muted" == "true" || "$volume" -eq 0 ]]; then
        icon=" "
    elif [[ "$volume" -lt 50 ]]; then
        icon=" "
    else
        icon=" "
    fi

    sketchybar --set volume icon="$icon" label="$volume%" \
               --set volume.popup.slider slider.percentage="$volume" 2>/dev/null
}

build_popup() {
    local volume output id device marker index click_command

    volume="$(current_volume)"
    [[ "$volume" =~ ^[0-9]+$ ]] || volume=0
    output="$(current_output)"

    sketchybar --remove '/volume\.popup\..*/' >/dev/null 2>&1

    sketchybar --add item volume.popup.output popup.volume \
               --set volume.popup.output icon=" " \
                                         icon.color="$BLUE" \
                                         label="Output: ${output:-Unavailable}" \
                                         label.max_chars=28 \
               \
               --add slider volume.popup.slider popup.volume 160 \
               --set volume.popup.slider icon.drawing=off \
                                         label.drawing=off \
                                         slider.percentage="$volume" \
                                         slider.highlight_color="$BLUE" \
                                         slider.background.height=4 \
                                         slider.background.corner_radius=2 \
                                         slider.background.color="$BACKGROUND_2" \
                                         slider.knob="●" \
                                         slider.knob.color="$WHITE" \
                                         script="$PLUGIN_DIR/volume.sh" \
               --subscribe volume.popup.slider mouse.clicked

    index=0
    while IFS=$'\t' read -r id device; do
        [[ -z "$id" || -z "$device" ]] && continue
        index=$((index + 1))
        marker="○"
        [[ "$device" == "$output" ]] && marker="✓"
        click_command="$PLUGIN_DIR/audio_device.sh $id"

        sketchybar --add item "volume.popup.device.$index" popup.volume \
                   --set "volume.popup.device.$index" icon="$marker" \
                                                        icon.color="$BLUE" \
                                                        label="$device" \
                                                        label.max_chars=28 \
                                                        click_script="$click_command"
    done < <(SwitchAudioSource -a -t output -f json 2>/dev/null | jq -r '[.id, .name] | @tsv')

    sketchybar --add item volume.popup.hint popup.volume \
               --set volume.popup.hint icon="􀼮 " \
                                       icon.color="$GREY" \
                                       label="Scroll the bar icon to adjust" \
                                       label.color="$GREY" \
               \
               --add item volume.popup.settings popup.volume \
               --set volume.popup.settings icon="􀍟 " \
                                           label="Open Sound Settings…" \
                                           click_script="open '$SOUND_SETTINGS'; sketchybar --set volume popup.drawing=off"
}

set_volume() {
    local volume="$1"

    [[ "$volume" =~ ^[0-9]+$ ]] || return
    (( volume < 0 )) && volume=0
    (( volume > 100 )) && volume=100
    osascript -e "set volume output volume $volume" >/dev/null
    update
}

scroll_volume() {
    local current delta next

    current="$(current_volume)"
    delta="${SCROLL_DELTA:-0}"
    [[ "$current" =~ ^[0-9]+$ && "$delta" =~ ^-?[0-9]+$ ]] || return

    if (( delta > 0 )); then
        next=$((current + 5))
    elif (( delta < 0 )); then
        next=$((current - 5))
    else
        return
    fi
    set_volume "$next"
}

mouse_clicked() {
    if [[ "$NAME" == "volume.popup.slider" ]]; then
        set_volume "${PERCENTAGE:-}"
        return
    fi

    if [[ "${BUTTON:-left}" == "right" ]]; then
        osascript -e 'set volume with output muted not (output muted of (get volume settings))' >/dev/null
        update
        return
    fi

    build_popup
    sketchybar --set volume popup.drawing=toggle
}

case "$SENDER" in
    mouse.clicked) mouse_clicked ;;
    mouse.scrolled) scroll_volume ;;
    *) update ;;
esac
