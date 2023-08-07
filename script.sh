#!/bin/bash

echo "Hello! This script will install the whole hyprland ecosystem along with configuration."
echo "If you aren't sure what software it will install and whether you want it, please consult with the README"

read -p "Now, are you sure you want to continue? [y/n] " -n 1 -r
echo " "
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Script canceled."
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi


# INTERNET CONNECTION
echo "Testing internet connection..."
curl -D- -o /dev/null -s http://www.google.com > /dev/null
if [[ $? == 0 ]]; then
  echo "Internet connected."
else
  echo "Internet not connected! Please try again!"
  exit 1
fi


# SYSTEM UPDATE
echo "Performing system update..."
sudo pacman -Syu


# YAY
echo "Installing Yay..."
sudo pacman -S git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
sudo rm -rf yay


# DISPLAY MANAGER
echo "Installing Display Manager..."
yay -S sddm-git


# WAYLAND
echo "Installing Wayland..."
sudo pacman -S wayland wlroots


# HYPRLAND
echo "Installing Desktop Environment..."
yay -S hyprland-git waybar-hyprland-git swww-git
sudo pacman -S alacritty wofi dunst polkit-kde-agent xdg-desktop-portal-hyprland cliphist


# AUDIO
echo "Installing Audio Server and utilities..."
yay -S pipewire-git  pipewire-alsa-git pipewire-jack-git pipewire-pulse-git wireplumber-git qjackctl-git pavucontrol-git


# FONTS
echo "Installing fonts and emoji..."
yay -S ttf-twemoji ttf-jetbrains-mono-nerd


# COLOR PICKER
echo "Installing color picker..."
sudo pacman -S hyprpicker


# ADDITIONALS
echo "Installing additional software..."
sudo pacman -S thunar gvfs thunar-volman gvfs-mtp tumbler ffmpegthumbnailer # thunar
sudo pacman -S viewnior vlc # media viewers
sudo pacman -S ranger htop alsa-utils vim neovim # cli
sudo pacman -S firefox ark gparted keepassxc qbittorrent # other

read -p "Do you want to install Joplin, Anki and Webcord? [y/n] " -n 1 -r
echo " "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Installing Joplin, Anki and Webcord..."
  yay -S joplin-desktop anki webcord
fi


# DEVELOPMENT
read -p "Do you want to install development tools? [y/n] " -n 1 -r
echo " "
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Installing development tools..."
  yay -S vscodium-bin
  sudo pacman -S virtualbox
fi


# STEAM
# echo "Installing steam ..."


# LIBRE OFFICE
# echo "Installing libre office"
# sudo pacman -S libreoffice


# DOT FILES
echo "Copying dotfiles..."
cp -r ./config/alacritty ~/.config/alacritty
cp -r ./config/eww ~/.config/eww
cp -r ./config/hypr ~/.config/hypr
cp -r ./config/waybar ~/.config/waybar
sudo cp -r ./wallpapers /usr/share/wallpapers