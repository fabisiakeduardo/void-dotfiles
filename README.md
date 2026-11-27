# dotfiles — Void-macOS-OLED

Personal dotfiles for my Arch + GNOME (Wayland) dev workstation.
Pure OLED black + Gargantua amber (`#ff8c38`) everywhere.

## Stack

- **OS**: Arch Linux, GNOME 51 (Wayland, 1080p@144Hz)
- **Terminal**: ghostty + fish + starship (`void-oled` theme)
- **Editor**: neovim (LazyVim), VS Code
- **CLI**: fzf, zoxide, eza, bat, ripgrep, fd, delta, btop, mise
- **Launcher**: [Vicinae](https://github.com/vicinaehq/vicinae) on `Super+Space`
  (Raycast-style; extracted AppImage at `~/.local/share/vicinae-app`,
  custom `void-oled` theme)
- **Themes**: `adw-gtk3-dark` GTK, `macOS` cursor
  ([apple_cursor](https://github.com/ful1e5/apple_cursor)), Papirus-Dark icons
- **GNOME ext**: Tiling Shell, Blur My Shell, Just Perfection, Space Bar,
  AppIndicator, user-theme (`Void-macOS-OLED`), Hanabi (live wallpaper)

## Tracked

- `.config/` — ghostty, fish, starship, nvim, tmux, btop, mise, fastfetch,
  `monitors.xml`, `dconf-settings.ini` (full `dconf dump /`, incl. all
  extension settings)
- `~/.bashrc`, `~/.gitconfig`
- `install-arch-stack.sh` — pacman/yay installer for a fresh Arch setup

## Install (bare repo method)

```bash
git clone --bare https://github.com/fabisiakeduardo/void-dotfiles.git $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

## GNOME settings

```bash
dconf load / < ~/.config/dconf-settings.ini
```

## Live wallpaper

[Hanabi](https://github.com/jeffshee/gnome-ext-hanabi) (built from `master`,
patched for GNOME 51, user-installed to `~/.local/share/gnome-shell/extensions`)
plays `~/Pictures/Wallpapers/blackhole-live.mp4` — a black hole accretion disk
loop (source: desktophut). Settings are in the dconf dump; the video itself is
not tracked (binary, ~38 MB).
