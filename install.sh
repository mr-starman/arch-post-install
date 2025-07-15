#!/usr/bin/env bash

set -e 

#------------------------------------------------------------------------------
# start
#------------------------------------------------------------------------------

echo -e "\nInstallation starting..."

# Update system
sudo pacman -Syu --noconfirm

#------------------------------------------------------------------------------
# yay
#------------------------------------------------------------------------------

if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel
  echo -e "\nInstalling yay..."
  cd /tmp
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd -
  rm -rf yay-bin
  cd ~
fi

#------------------------------------------------------------------------------
# packages 
#------------------------------------------------------------------------------

echo -e "\nInstalling packages..."

# system stuff
yay -S --needed --noconfirm \
  base-devel \
  bash-completion \
  reflector \
  intel-ucode 

sleep 2

# xorg, display server 
yay -S --needed --noconfirm \
  xorg \
  xclip

sleep 2

# display manager
yay -S --needed --noconfirm \
  gdm \
  gnome-shell \
  gnome-control-center \
  gnome-session \
  gnome-keyring \
  gnome-tweaks \
  gnome-terminal \
  gnome-themes-extra

sleep 2

# fonts
yay -S --needed --noconfirm \
  noto-fonts-emoji \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd

sleep 2

# network
yay -S --needed --noconfirm \
  blueman \
  bluez-utils

sleep 2

# dev stuff
yay -S --needed --noconfirm \
  alacritty \
  bat \
  neovim \
  fd \
  ripgrep \
  fzf \
  jq \
  shellcheck \
  tree \
  tldr

sleep 2

# apps
yay -S --needed --noconfirm \
  brave-bin \
  freetube-bin \
  spotify

#------------------------------------------------------------------------------
# dotfiles
#------------------------------------------------------------------------------

echo -e "\nInstalling dotfiles..."

rm -rf "$HOME"/dotfiles

git clone https://github.com/mr-starman/dotfiles "$HOME"/dotfiles

"$HOME"/dotfiles/install.sh

#------------------------------------------------------------------------------
# gnome
#------------------------------------------------------------------------------

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Control>w']"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Shift><Control>t'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'Alacritty'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Freetube'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Shift><Control>y'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'freetube'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Spotify'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Shift><Control>m'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'spotify'

gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Shift><Control>s']"
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Shift><Control>h']"

mkdir -p "$HOME"/.local/share/backgrounds
cp "$HOME"/arch-post-install/images/catppuccin-bg.png "$HOME"/.local/share/backgrounds/
gsettings set org.gnome.desktop.background picture-uri "'file:///$HOME/.local/share/backgrounds/catppuccin-bg.png'"
gsettings set org.gnome.desktop.background picture-uri-dark "'file:///$HOME/.local/share/backgrounds/catppuccin-bg.png'"

#------------------------------------------------------------------------------
# gdm
#------------------------------------------------------------------------------

echo -e "\nEnabling GDM..."

sudo systemctl enable gdm.service

#------------------------------------------------------------------------------
# grub
#------------------------------------------------------------------------------

echo -e "\nRegenerating grub config..."

sudo grub-mkconfig -o /boot/grub/grub.cfg

#------------------------------------------------------------------------------
# finished
#------------------------------------------------------------------------------

echo -e "\nInstall finished...reboot to take effect"

