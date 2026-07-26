# macOS dotfiles

A keyboard-driven macOS environment inspired by Omarchy/Hyprland.

## Configuration

- [Ghostty](https://ghostty.org/) — [`.config/ghostty`](./.config/ghostty/)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar) with SbarLua — [`.config/sketchybar`](./.config/sketchybar/)
- [yabai](https://github.com/koekeishiya/yabai) — [`.config/yabai`](./.config/yabai/)
- [skhd](https://github.com/koekeishiya/skhd) — [`.config/skhd`](./.config/skhd/)
- [Raycast](https://www.raycast.com/) — launcher and clipboard history

## Dotfile management

This repository follows the bare-repository layout used by
[rockyzhang24/dotfiles](https://github.com/rockyzhang24/dotfiles). Files mirror
their destination beneath `$HOME`; no Stow package directories or symlinks are
needed.

### Initial setup

```bash
git init --bare "$HOME/dotfiles"
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dot config status.showUntrackedFiles no
dot remote add origin https://github.com/ShobhanKarthish/dotfiles.git
```

### Clone on another Mac

```bash
git clone --bare https://github.com/ShobhanKarthish/dotfiles.git "$HOME/dotfiles"
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
mkdir -p "$HOME/.config-backup"
dot checkout 2>&1 | grep -E '^\s+\.' | awk '{print $1}' | xargs -I{} mv "$HOME/{}" "$HOME/.config-backup/{}"
dot checkout
dot config status.showUntrackedFiles no
brew bundle --file "$HOME/Brewfile"
```

On macOS, Ghostty also checks its Application Support location. Link it to the
tracked XDG configuration so there is one source of truth:

```bash
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
ln -sfn "$HOME/.config/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
ln -sfn "$HOME/.config/ghostty/shaders" "$HOME/Library/Application Support/com.mitchellh.ghostty/shaders"
ln -sfn "$HOME/.config/ghostty/themes" "$HOME/Library/Application Support/com.mitchellh.ghostty/themes"
```

Build SbarLua once:

```bash
tmp=$(mktemp -d /tmp/SbarLua.XXXXXX)
git clone --depth 1 https://github.com/FelixKratz/SbarLua.git "$tmp"
make -C "$tmp" install
rm -rf "$tmp"
```

Start the desktop services:

```bash
yabai --start-service
skhd --start-service
brew services start sketchybar
```

Grant **yabai** and **skhd** access under **System Settings → Privacy & Security
→ Accessibility**.

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

Ghostty maps `⌘V` to pi's `Ctrl+V` handler so clipboard images can be pasted
into pi. This changes `⌘V` behavior in all Ghostty sessions.
