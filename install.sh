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

#------------------------------------------------------------------------------
# packages 
#------------------------------------------------------------------------------
echo -e "\nInstalling packages..."

yay -S --noconfirm --needed \
  7zip \
  alacritty \
  bash-completion \
  bat \
  blueman \
  bluez-utils \
  brave-bin \
  fastfetch \
  fd \
  fzf \
  gdm \
  git \
  git-completion \
  gnome-backgrounds \
  gnome-control-center \
  gnome-disk-utility \
  gnome-keyring \
  gnome-session \
  gnome-settings-daemon \
  gnome-shell \
  gnome-shell-extension-weather-oclock \
  gnome-terminal \
  gnome-themes-extra \
  gnome-tweaks \
  grub \
  gst-plugin-pipewire \
  gvfs \
  intel-ucode \
  jq \
  nautilus \
  neovim \
  network-manager-applet \
  noto-fonts-emoji \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  reflector \
  ripgrep \
  shellcheck \
  sof-firmware \
  tldr \
  tree \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  usbutils \
  vim \
  wget \
  xclip \
  xf86-video-vesa \
  xorg \
  xq 

echo -e "\nInstalling finished...reboot"
