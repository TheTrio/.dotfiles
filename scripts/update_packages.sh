#!/bin/bash
pacman -Qqen > /home/shashwat/stow/packages/packages.txt
pacman -Qqem > /home/shashwat/stow/packages/aur_packages.txt
flatpak list | cut -f 2 > /home/shashwat/stow/packages/flatpak_packages.txt