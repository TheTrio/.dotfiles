#!/bin/bash
pacman -Qqen > ~/stow/packages/packages.txt
pacman -Qqem | grep -vi chaotic > ~/stow/packages/aur_packages.txt
flatpak list | cut -f 2 | grep -vi platform > ~/stow/packages/flatpak_packages.txt
