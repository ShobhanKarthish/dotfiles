# macOS dotfiles

Omarchy/Hyprland-inspired macOS setup using:

- **yabai** for BSP window tiling
- **skhd** for keyboard shortcuts
- **SketchyBar** for workspaces and system status
- **Ghostty** terminal configuration
- **Raycast** as the launcher

## Layout

This repository uses [GNU Stow](https://www.gnu.org/software/stow/). Each top-level package mirrors its destination under `$HOME`:

```text
yabai/.yabairc
skhd/.skhdrc
sketchybar/.config/sketchybar/
ghostty/Library/Application Support/com.mitchellh.ghostty/config
```

## Install

```bash
git clone https://github.com/ShobhanKarthish/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

Then grant **yabai** and **skhd** access in **System Settings → Privacy & Security → Accessibility**.

Reload Ghostty with `⌘⇧,` after installing.

## Main shortcuts

`⌥` acts as the Super key.

| Shortcut | Action |
|---|---|
| `⌘ Space` | Open Raycast |
| `⌥⌘V` | Open Raycast Clipboard History |
| `⌥ Return` | Open Ghostty |
| `⌥H` | Open Helium |
| `⌥J/K/L` | Focus down/up/right |
| `⌥⇧ Arrow` | Move window in that direction |
| `⌥ Space` | Toggle floating |
| `⌥F` | Toggle fullscreen |
| `⌥1–9` | Focus space |
| `⌥⇧1–9` | Move window to space |

Ghostty maps `⌘V` to pi's `Ctrl+V` handler so clipboard images can be pasted into pi. This changes `⌘V` behavior in all Ghostty sessions.
