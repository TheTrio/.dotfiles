#!/bin/bash
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
mapfile -t packages < "$SCRIPT_DIR/../packages/packages.txt"
mapfile -t aur_packages < "$SCRIPT_DIR/../packages/aur_packages.txt"

source "$SCRIPT_DIR/formatting.sh"

print_update "Installing pacman packages"


install_packages () {
  sudo pacman -S --needed --noconfirm - < "$SCRIPT_DIR/../packages/packages.txt"
}


print_update "Installing AUR packages"

install_aur_packages () {
  paru -S --needed --noconfirm - < "$SCRIPT_DIR/../packages/aur_packages.txt"
}

printf "${Blue}Installed all packages successfully\n"
