#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Arch Linux System Stack Installer — Void-macOS-OLED + Omarchy/Omakub Dev Setup
# Run once in your terminal: bash ~/install-arch-stack.sh
# ==============================================================================

echo "============================================================"
echo "  Void-macOS-OLED + Omarchy/Omakub — Arch Package Installer"
echo "============================================================"

echo ""
echo "[1/5] Installing Terminal, Fish Shell, Rust CLI Suite, Fonts & GNOME Extensions..."
sudo pacman -S --needed --noconfirm \
  ghostty \
  fish \
  starship \
  fzf \
  zoxide \
  eza \
  bat \
  ripgrep \
  fd \
  dust \
  procs \
  bottom \
  sd \
  hyperfine \
  tokei \
  yazi \
  atuin \
  xh \
  ouch \
  gping \
  difftastic \
  hexyl \
  choose \
  ast-grep \
  gitui \
  grex \
  trippy \
  bandwhich \
  btop \
  fastfetch \
  neovim \
  lazygit \
  git-delta \
  github-cli \
  jq \
  yq \
  curlie \
  tmux \
  tealdeer \
  uv \
  docker \
  docker-compose \
  wl-clipboard \
  ttf-jetbrains-mono-nerd \
  ttf-firacode-nerd \
  ttf-cascadia-code-nerd \
  inter-font \
  papirus-icon-theme \
  gnome-shell-extensions \
  gnome-browser-connector

echo ""
echo "[2/5] Installing Visual Studio Code (Official Microsoft binary via AUR)..."
rm -rf "$HOME/.cache/yay/visual-studio-code-bin"
yay -S --needed --noconfirm --answerclean All --answerdiff None visual-studio-code-bin

echo ""
echo "[3/5] Installing essential VS Code extensions..."
for ext in \
  PKief.material-icon-theme \
  esbenp.prettier-vscode \
  dbaeumer.vscode-eslint \
  ms-python.python \
  redhat.java \
  eamodio.gitlens; do
  code --install-extension "$ext" --force || true
done

echo ""
echo "[4/5] Enabling Docker group, Fish default shell, Git Delta & GNOME User Theme..."
sudo systemctl enable --now docker.service 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

# Configure git-delta cleanly (keeps your existing user.name / user.email untouched)
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global delta.line-numbers true
git config --global merge.conflictstyle zdiff3

# Enable User Themes & apply Void-macOS-OLED + Papirus-Dark
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com 2>/dev/null || true
if [ -d "/usr/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com/schemas" ]; then
  gsettings --schemadir /usr/share/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com/schemas \
    set org.gnome.shell.extensions.user-theme name 'Void-macOS-OLED' 2>/dev/null || true
fi
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 2>/dev/null || true
fc-cache -fv >/dev/null 2>&1 || true

# Set Fish as default login shell
if [ "$SHELL" != "/usr/bin/fish" ]; then
  echo "Setting Fish as default shell (may prompt for your password)..."
  chsh -s /usr/bin/fish
fi

echo ""
echo "[5/5] Starting Hidamari Animated Black Hole Wallpaper..."
flatpak kill io.github.jeffshee.Hidamari 2>/dev/null || true
systemctl --user stop hidamari-live.service 2>/dev/null || true
systemctl --user reset-failed hidamari-live.service 2>/dev/null || true
systemd-run --user --unit=hidamari-live flatpak run io.github.jeffshee.Hidamari --background >/dev/null 2>&1 || true

echo ""
echo "============================================================"
echo "  TUDO PRONTO! Faça logout e login no GNOME para ativar"
echo "  todas as extensões GNOME 51, o tema Shell e o Fish!"
echo "============================================================"
