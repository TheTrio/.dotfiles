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

aur_packages=(
  "vim-plug"
  "google-chrome"
  "libinput-gestures"
  "visual-studio-code-bin"
  "ncspot"
  "ulauncher"
  "insomnia-bin"
)

source formatting.sh

print_update "Installing pacman packages"

install_packages () {
  i=1
  len=${#packages[@]}
  for package in "${packages[@]}";do
    printf "${Yellow}Installing ${package}. ${Blue}(${i}/${len})\n${Color_Off}"
    sudo pacman -S --needed --noconfirm $package
    i=$((i+1))
  done
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