# Macchiato Nocturne

A personal fork of [Omarchy Macchiato Core](https://github.com/hembramnishant50-glitch/omarchy-macchiato-core-theme),
tuned for a darker, night-time Catppuccin Macchiato desk.

## Install

```bash
git clone https://github.com/iam-wisman/macchiato-nocturne
./macchiato-nocturne/install.sh
```

Use the script rather than `omarchy theme install`. Omarchy treats a theme that
still has its `.git` folder as third-party and skips its Hyprland, terminal,
Neovim and gum configs every time it is applied, so the gradient border,
animations and Kitty cursor trail would be lost. `install.sh`:

- installs the theme as a plain folder so Omarchy applies every file
- adds a `theme-set` hook that applies the theme's `starship.toml`, `tmux.conf`
  and `fastfetch.jsonc` (Omarchy doesn't do this by itself)
- turns on the Kitty cursor blink that Omarchy's default `kitty.conf` disables
- applies the theme and sets the default wallpaper

It is safe to re-run, and backs up any file it changes outside the theme. The
clone can be deleted afterwards.

## Changes from Macchiato Core

- **Icons:** Yaru-purple (Omarchy's own icon set, matches the mauve accent) instead of Papirus-Dark
- **Window borders:** mauve → blue 45° gradient on the active window; inactive borders use
  Surface1 `#494d64` so they recede instead of competing with the focused window
- **Shadow:** uses Crust `#181926` from the palette instead of an off-palette navy
- **Keyboard backlight:** mauve `#c6a0f6` to match the accent (was blue)
- **Terminal cursor:** mauve `#c6a0f6` in Kitty, Alacritty, Ghostty and Foot; Kitty also gets a
  mauve cursor trail and a smooth ease-in-out blink
- **Ghostty:** background now matches the other terminals (Mantle `#1e2030`, was Base `#24273a`)
- **Copy on select:** selecting text in Kitty, Alacritty or Ghostty copies it to the clipboard
  (Foot has no option for this; it only fills the primary selection)
- **Starship:** `username` uses `style_user` (fixes the "Unknown key" warning)
- **Wallpapers:** 12 extra dark, palette-friendly wallpapers from Wallhaven (`nocturne-*`)

## Wallpaper credits (wallhaven.cc)

| File | Source |
|------|--------|
| `nocturne-01-jevz8y.png` | https://wallhaven.cc/w/jevz8y |
| `nocturne-02-1qkz23.png` | https://wallhaven.cc/w/1qkz23 |
| `nocturne-03-qr3mpq.png` | https://wallhaven.cc/w/qr3mpq |
| `nocturne-04-e86ggr.png` | https://wallhaven.cc/w/e86ggr |
| `nocturne-05-zpx3xw.png` | https://wallhaven.cc/w/zpx3xw |
| `nocturne-06-gpjk37.jpg` | https://wallhaven.cc/w/gpjk37 |
| `nocturne-07-p8kyvm.jpg` | https://wallhaven.cc/w/p8kyvm |
| `nocturne-08-4338zy.jpg` | https://wallhaven.cc/w/4338zy |
| `nocturne-09-1p55dw.png` | https://wallhaven.cc/w/1p55dw |
| `nocturne-10-zp86wv.png` | https://wallhaven.cc/w/zp86wv |
| `nocturne-11-yqmqk7.png` | https://wallhaven.cc/w/yqmqk7 |
| `nocturne-12-zyp7jo.jpg` | https://wallhaven.cc/w/zyp7jo |
