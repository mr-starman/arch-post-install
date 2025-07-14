#/bin/bash

set -e 

echo -e "\nInstallation starting..."

#------------------------------------------------------------------------------
# yay
#------------------------------------------------------------------------------

sudo pacman -S --needed --noconfirm base-devel

if ! command -v yay &>/dev/null; then
  echo -e "\nInstalling yay..."
  cd /tmp
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd -
  rm -rf yay-bin
  cd ~
fi

yay -Syu --noconfirm

#------------------------------------------------------------------------------
# packages 
#------------------------------------------------------------------------------

echo -e "\nInstalling packages..."

yay -Syu --noconfirm

# system stuff
yay -S --needed --noconfirm \
  base-devel \
  bash-completion \
  reflector \
  intel-ucode 

# xorg, display server 
yay -S --needed --noconfirm \
  xorg \
  xclip

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

# fonts
yay -S --needed --noconfirm \
  noto-fonts-emoji \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd

# network
yay -S --needed --noconfirm \
  blueman \
  bluez-utils \
  bridge-utils 

# dev stuff
yay -S --needed --noconfirm \
  git-completion \
  neovim \
  fd \
  ripgrep \
  fzf \
  jq \
  shellcheck \
  tree \
  tldr

# apps
yay -S --needed --noconfirm \
  alacritty \
  brave-bin \
  spotify

#------------------------------------------------------------------------------
# dotfiles
#------------------------------------------------------------------------------

echo -e "\nInstalling dotfiles..."

rm -rf "$HOME"/dotfiles

git clone https://github.com/mr-starman/dotfiles "$HOME"/dotfiles

"$HOME"/dotfiles/install.sh

#------------------------------------------------------------------------------
# GDM
#------------------------------------------------------------------------------

echo -e "\nEnabling GDM..."

sudo systemctl enable gdm.service

echo -e "\nInstall finished...reboot to take effect"

