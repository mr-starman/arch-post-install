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
  bridge-utils \
  btrfs-progs \
  cheese \
  dbeaver \
  dmidecode \
  dnsmasq \
  docker \
  docker-compose \
  edk2-ovmf \
  efibootmgr \
  fastfetch \
  fd \
  freetube \
  fzf \
  gdm \
  gdm-settings \
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
  grub-btrfs \
  grub-customizer \
  gst-plugin-pipewire \
  gvfs \
  inotify-tools \
  intel-ucode \
  intellij-idea-community-edition \
  jdk-openjdk \
  jq \
  ledger-live-bin \
  libpulse \
  libvirt \
  maven \
  megacmd \
  nautilus \
  neovim \
  network-manager-applet \
  networkmanager \
  noto-fonts-emoji \
  npm \
  openbsd-netcat \
  pipewire \
  pipewire-alsa \
  pipewire-jack \
  pipewire-pulse \
  postman-bin \
  qemu-full \
  reflector \
  ripgrep \
  shellcheck \
  sof-firmware \
  spotify \
  timeshift \
  timeshift-autosnap \
  tldr \
  tomcat10 \
  tree \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  usbutils \
  vde2 \
  vim \
  virglrenderer \
  virt-manager \
  virt-viewer \
  visual-studio-code-bin \
  vivid \
  wget \
  wireplumber \
  xclip \
  xdg-utils \
  xf86-video-vesa \
  xorg \
  xq \
  zram-generator

echo -e "\nInstalling finished...reboot"
