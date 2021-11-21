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
  len=${#aur_packages[@]}
  for package in "${aur_packages[@]}";do
    printf "${Yellow}Installing ${package}. ${Blue}(${i}/${len})\n${Color_Off}"
    yay -S --needed --noconfirm --removemake --nodiffmenu $package
    i=$((i+1))
  done
}

printf "${Blue}Installed all packages successfully\n"