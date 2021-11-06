#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# exits the script as soon as a non zero exit code is found
set -e

cols=$(tput cols)
done=1
total=13


packages=(
  "vim" 
  "nano"
  "vi"
  "sudo"
  "wget"
  "curl"
  "unzip"
  "git"
  "base-devel"
  "xorg-server" 
  "plasma" 
  "sddm"
  "kitty"
  "fish"
  "xf86-video-amdgpu"
  "vulkan-radeon"
  "libva-mesa-driver"
  "mesa-vdpau"
  "mesa"
  "nvidia"
  "nvidia-prime"
  "gwenview"
  "kwalletmanager"
  "kwallet"
  "partitionmanager"
  "dolphin"
  "noto-fonts"
  "noto-fonts-emoji"
  "noto-fonts-cjk"
  "ttf-jetbrains-mono"
  "lsd"
  "bat"
  "neofetch"
  "lolcat"
  "firefox"
  "gnome-keyring"
  "pyenv"
  "openssl"
  "zlib"
  "xz"
  "ncdu"
  "htop"
  "discord"
  "bluez"
  "bluez-utils"
)

aur_packaes=(
  "vim-plug"
  "google-chrome"
  "libinput-gestures"
  "visual-studio-code-bin"
  "ncspot"
  "ulauncher"
)

print_middle () {
  string=$1
  len=${#string}
  len=$((len + 2))
  num=$(((cols - len) / 2))
  for i in $(seq $num); do
    printf "#"
  done
  if [ $(((cols-len) % 2)) != 0 ]; then
    num=$((num+1))
  fi
  printf "${Blue} ${string} "
  for i in $(seq $num); do
    printf "${Red}#"
  done
}

print_line () {
  for i in $(seq $cols);do
    printf "${Red}#"
  done
}

print_update () {
  print_line
  print_middle "${1}"
  print_line
  printf "\n\n"
}

install_packages () {
  i=1
  len=${#packages[@]}
  for package in "${packages[@]}";do
    printf "${Yellow}Installing ${package}. ${Blue}(${i}/${len})\n${Color_Off}"
    sudo pacman -S --needed --noconfirm $package
    i=$((i+1))
  done
  done=$((done+1))
}

make_swap_file () {
  sudo dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  sudo echo "/swapfile none swap defaults 0 0" >> /etc/fstab
  done=$((done+1))
}

install_yay () {
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ..
  rm -rf yay
  done=$((done+1))
}

enable_sddm () {
  sudo systemctl enable sddm
  done=$((done+1))
}

enable_network () {
  sudo systemctl enable NetworkManager
  sudo systemctl start NetworkManager
  done=$((done+1))
}

enable_bluetooth() {
  sudo systemctl enable bluetooth --now
  done=$((done+1))
}

setup_symlinks () {
  ln -sf $PWD/.config/kitty ~/.config
  ln -sf $PWD/.config/fish/config.fish ~/.config/fish/
  ln -sf $PWD/.bashrc ~/.bashrc
  ln -sf $PWD/.bash_aliases ~/.bash_aliases
  ln -sf $PWD/.config/lsd ~/.config
  ln -sf $PWD/.config/oh_my_posh ~/.config
  ln -sf $PWD/.vimrc ~/.vimrc
  ln -sf $PWD/.config/libinput-gestures.conf ~/.config
  done=$((done+1))
}

setup_fish () {
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  done=$((done+1))
}

setup_posh () {
  sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
  sudo chmod +x /usr/local/bin/oh-my-posh
  mkdir ~/.poshthemes
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
  unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
  chmod u+rw ~/.poshthemes/\*.json
  rm ~/.poshthemes/themes.zip
  done=$((done+1))
}

install_aur_packages () {
  for package in "${aur_packaes[@]}";do
    printf "${Yellow}Installing ${package}. ${Blue}(${i}/${len})\n${Color_Off}"
    yay -S --needed --noconfirm --removemake --nodiffmenu $package
    i=$((i+1))
  done
  done=$((done+1))
}

setup_mouse_gestures () {
  libinput-gestures-setup autostart start
  done=$((done+1))
}


setup_python () {
  pyenv install 3.9
  pyenv install 3.8
  done=$((done+1))
}

setup_node () {
  fisher install jorgebucaran/nvm.fish
  nvm install 14
  nvm install 16
  done=$((done+1))
}

if [ $(id -u) == 0 ]; then
  printf "${Red}You must not be root\n"
  normal_user=$(awk -F: '{
    if($3>=1000 && $1!="nobody"){
      printf $3
      printf "\n"
    }
  }' /etc/passwd | wc -l)
  if [ $normal_user -le 1 ]; then
    printf "${Yellow}No regular user found\n\n"
    printf "${White}Do you want to create it?(y/N) "
    read create_user
    bool_create_user=$(printf "${create_user}\n" | sed -n '/^[yY]/p' | wc -l)
    if [ $bool_create_user -eq 1 ]; then
      read -p "Enter valid username: " username
      if [ "$username" == "" ]; then
        printf "${Red}No username provided\n\n"
      else
        printf "${Blue}Creating user\n"
        useradd $username -m -G wheel,input,disk,audio,video,storage
        passwd $username
        printf "${Green}User created. Please login in using this user\n"
      fi
    fi
  fi
  printf "${White}Exiting ...\n"
  exit
fi



git clone https://github.com/TheTrio/.dotfiles.git ~/.dotfiles
cd .dotfiles
t=("vim" "kitty")

print_update "Installing Pacman Packages(${done} of ${total})"
install_packages


print_update "Making swap file(${done} of ${total})"
make_swap_file

print_update "Installing yay(${done} of ${total})"
install_yay

print_update "Enabling graphics(${done} of ${total})"
enable_sddm

print_update "Setting up the network(${done} of ${total})"
enable_network

print_update "Setting up bluetooth(${done} of ${total})"
enable_bluetooth

print_update "Setting up the symlinks(${done} of ${total})"
setup_symlinks

print_update "Setting up fish shell(${done} of ${total})"
setup_fish

print_update "Setting up Oh my posh(${done} of ${total})"
setup_posh

print_update "Installing AUR Packages(${done} of ${total})"
install_aur_packages

print_update "Setting up mouse gestures(${done} of ${total})"
setup_mouse_gestures

print_update "Setting up python(${done} of ${total})"
setup_python

print_update "Setting up Node(${done} of ${total})"
setup_node

printf "\033c"
printf "${Green}Installation completed successfully.${White}\n\n"

printf "${Yellow}Remember to read the guide for any other instructions!\n\n"

read -p "Restart?(Y/n): " restart_choice
if [ $restart_choice == "" || $restart_choice == "y" || $restart_choice == "Y" ]; then
  reboot

printf "${Blue}Exiting gracefully"