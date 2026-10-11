#!/bin/bash
# omarchy:summary=Apply a theme's starship, tmux and fastfetch extras, or restore Omarchy defaults
#
# Themes like One Piece and Macchiato Core ship starship.toml, tmux.conf and
# fastfetch.jsonc next to their colors. Omarchy doesn't apply those itself, so
# this hook copies them into place when the theme has them and puts the
# Omarchy default back when it doesn't. Edits made directly to these three
# files in ~/.config are overwritten on the next theme change -- edit the
# theme's copy instead.

THEME="$HOME/.local/state/omarchy/current/theme"
DEFAULTS="${OMARCHY_PATH:-/usr/share/omarchy}/config"
MARKER="$HOME/.config/fastfetch/.theme-managed"

# Starship
if [[ -f $THEME/starship.toml ]]; then
  cp "$THEME/starship.toml" "$HOME/.config/starship.toml"
else
  cp "$DEFAULTS/starship.toml" "$HOME/.config/starship.toml"
fi

# Tmux
mkdir -p "$HOME/.config/tmux"
if [[ -f $THEME/tmux.conf ]]; then
  cp "$THEME/tmux.conf" "$HOME/.config/tmux/tmux.conf"
else
  cp "$DEFAULTS/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
fi
if tmux list-sessions >/dev/null 2>&1; then
  tmux source-file "$HOME/.config/tmux/tmux.conf" >/dev/null 2>&1 || true
fi

# Fastfetch: only ever remove a config this hook created, never a hand-written one
if [[ -f $THEME/fastfetch.jsonc ]]; then
  if [[ ! -f $HOME/.config/fastfetch/config.jsonc || -f $MARKER ]]; then
    mkdir -p "$HOME/.config/fastfetch"
    cp "$THEME/fastfetch.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    touch "$MARKER"
  fi
elif [[ -f $MARKER ]]; then
  rm -f "$HOME/.config/fastfetch/config.jsonc" "$MARKER"
fi
