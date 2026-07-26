#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

brew bundle

if [ ! -f "$HOME/.local/share/sketchybar_lua/sketchybar.so" ]; then
  sbarlua_dir=$(mktemp -d /tmp/SbarLua.XXXXXX)
  git clone --depth 1 https://github.com/FelixKratz/SbarLua.git "$sbarlua_dir"
  make -C "$sbarlua_dir" install
  rm -rf "$sbarlua_dir"
fi

for package in yabai skhd sketchybar ghostty; do
  stow --target="$HOME" --restow "$package"
done

chmod +x "$HOME/.yabairc" "$HOME/.skhdrc"
chmod +x "$HOME/.config/sketchybar/sketchybarrc"

yabai --start-service || yabai --restart-service
skhd --start-service || skhd --restart-service
brew services restart sketchybar

echo "Installed. Grant yabai and skhd Accessibility access in System Settings."
