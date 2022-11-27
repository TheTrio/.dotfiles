#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
mapfile -t packages < "$SCRIPT_DIR/../packages/packages.txt"
mapfile -t aur_packages < "$SCRIPT_DIR/../packages/aur_packages.txt"

source "$SCRIPT_DIR/formatting.sh"


install_packages () {
  sudo pacman -S --needed --noconfirm - < "$SCRIPT_DIR/../packages/packages.txt"
}

install_aur_packages () {
  paru -S --needed --noconfirm - < "$SCRIPT_DIR/../packages/aur_packages.txt"
}


install_flatpak_packages () {
  cat packages/flatpak_packages.txt | xargs flatpak install
}

if [ "$1" = "yes" ]; then
  install_packages
  install_aur_packages
  install_flatpak_packages
  printf "${Blue}Installed all packages successfully\n"
fi
