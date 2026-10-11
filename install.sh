#!/bin/bash
# Install Macchiato Nocturne with everything it ships, then apply it.
#
# `omarchy theme install <url>` keeps the clone's .git, and Omarchy drops a
# cloned theme's *.lua, terminal configs and vscode.json every time the theme is
# applied. That loses the gradient border, animations, gum colours and the
# Kitty cursor trail. This script installs the theme as a plain directory
# instead, so Omarchy treats it as the user's own and stages every file.
#
# Usage:
#   git clone https://github.com/iam-wisman/macchiato-nocturne
#   ./macchiato-nocturne/install.sh
#
# Safe to run again: it replaces the installed theme and skips anything that is
# already in place. Every file it changes outside the theme is backed up first.

set -euo pipefail

THEME_NAME=macchiato-nocturne
THEMES_DIR="$HOME/.config/omarchy/themes"
DEST="$THEMES_DIR/$THEME_NAME"
HOOK_DIR="$HOME/.config/omarchy/hooks/theme-set.d"
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
DEFAULT_BG=nocturne-01-jevz8y.png
STAMP=$(date +%s)

say() { printf '\e[35m::\e[0m %s\n' "$*"; }

install_theme() {
  local src=$1 stage

  stage=$(mktemp -d)
  tar -C "$src" --exclude=install.sh --exclude=extras --exclude=README.md -cf - . | tar -C "$stage" -xf -

  mkdir -p "$THEMES_DIR"
  rm -rf "$DEST"
  mv "$stage" "$DEST"
  chmod 755 "$DEST"
  say "Installed theme to $DEST"
}

install_extras_hook() {
  local src=$1/extras/hooks/theme-extras.sh dest=$HOOK_DIR/theme-extras.sh

  # Omarchy doesn't apply a theme's starship.toml, tmux.conf or fastfetch.jsonc;
  # this hook does, on every theme change.
  if [[ -f $dest ]] && cmp -s "$src" "$dest"; then
    say "Theme extras hook already installed"
    return
  fi
  [[ -f $dest ]] && cp "$dest" "$dest.bak.$STAMP"
  mkdir -p "$HOOK_DIR"
  install -m 755 "$src" "$dest"
  say "Installed theme extras hook (starship, tmux, fastfetch)"
}

enable_kitty_blink() {
  # Omarchy's default kitty.conf turns blinking off after the theme include,
  # which overrides the theme's ease-in-out blink.
  [[ -f $KITTY_CONF ]] || return 0
  if grep -q '^cursor_blink_interval 0$' "$KITTY_CONF"; then
    cp "$KITTY_CONF" "$KITTY_CONF.bak.$STAMP"
    sed -i 's/^cursor_blink_interval 0$/# cursor blink comes from the theme (ease-in-out fade)/' "$KITTY_CONF"
    say "Enabled Kitty cursor blink from the theme"
  fi
}

check_icons() {
  local icons
  icons=$(<"$DEST/icons.theme")
  [[ -d /usr/share/icons/$icons || -d $HOME/.local/share/icons/$icons ]] && return
  say "Icon theme $icons is missing; install it with: omarchy pkg add yaru-icon-theme"
}

main() {
  local repo
  repo=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

  command -v omarchy >/dev/null || { echo "Omarchy not found; this theme is for Omarchy." >&2; exit 1; }

  # Work from a copy: the clone may be $DEST itself (after `omarchy theme
  # install`), which install_theme replaces.
  SRC=$(mktemp -d)
  trap 'rm -rf "$SRC"' EXIT
  tar -C "$repo" --exclude=.git -cf - . | tar -C "$SRC" -xf -

  install_theme "$SRC"
  install_extras_hook "$SRC"
  enable_kitty_blink
  check_icons

  omarchy theme set "$THEME_NAME"
  omarchy theme bg set "$DEST/backgrounds/$DEFAULT_BG" >/dev/null
  omarchy restart terminal >/dev/null 2>&1 || true
  say "Macchiato Nocturne applied"
}

# Everything runs from main so bash has read the whole script before the
# install step can replace the directory it lives in.
main "$@"
exit
