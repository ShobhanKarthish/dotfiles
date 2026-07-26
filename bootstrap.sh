#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

brew bundle

for package in yabai skhd sketchybar ghostty; do
  stow --target="$HOME" --restow "$package"
done

chmod +x "$HOME/.yabairc" "$HOME/.skhdrc"
chmod +x "$HOME/.config/sketchybar/sketchybarrc" "$HOME/.config/sketchybar/plugins/"*.sh

yabai --start-service || yabai --restart-service
skhd --start-service || skhd --restart-service
brew services restart sketchybar

echo "Installed. Grant yabai and skhd Accessibility access in System Settings."
