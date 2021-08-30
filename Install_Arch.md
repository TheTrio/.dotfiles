## Stepwise Installation guide

This is work in progress

## Install the essentials

```
pacman -Syu vim nano vi sudo wget curl unzip
```

## User management

```
useradd shashwat -h -g wheel,input,disk,audio,video,storage
passwd shashwat
```

Following this editor the sudoers file to ensure that the users in the wheel group can run commands as the root user.

## Swap file

```
dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sudo echo "/swapfile none swap defaults 0 0" >> /etc/fstab
```

## Installing Yay

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

## Install a Desktop Environment

```
pacman -Syu xorg-server plasma sddm
systemctl enable sddm
reboot
```

## Enable Network Manager

```
systemctl enable NetworkManager
systemctl start NetworkManager
```

## Install Kitty

```
pacman -Syu kitty
ln -sf $PWD/.config/kitty ~/.config
```

## Configure shells

### Fish

```
pacman -Syu fish
ln -sf $PWD/.config/fish/config.fish ~/.config/fish/
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

### Bash

```
ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.bash_aliases ~/.bash_aliases
```

## Enabling hardware acceleration

```

pacman -Syu xf86-video-amdgpu vulkan-radeon libva-mesa-driver mesa-vdpau mesa

```

## GPU drivers

Run the following to get the current drivers

```

lspci -k | grep -A 2 -E "(VGA|3D)"

```

Install proprietary nvidia drivers with

```

pacman -Syu nvidia nvidia-prime

```

## Installing essential KDE Applications

```

pacman -S gwenview kwalletmanager kwallet partitionmanager dolphin

```

## Making the terminal look pretty

### Fonts

```

sudo pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono

```

### LSD

```

pacman -Syu lsd
ln -sf $PWD/.config/lsd ~/.config

```

### BAT

```

pacman -Syu bat

```

### Oh my posh

```

wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/\*.json
rm ~/.poshthemes/themes.zip

ln -sf $PWD/.config/oh_my_posh ~/.config

```

### Pokemon colorscripts

```

git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
cd pokemon-colorscripts/
sudo ./install.sh

```

### Vim Plugins

The following plugins are installed by default

1. [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim)
2. [itchyny/lightline.vim](https://github.com/itchyny/lightline.vim)
3. [preservim/nerdtree](https://github.com/preservim/nerdtree)
4. [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)

The Plugin manager I use is [Vim Plug](https://github.com/junegunn/vim-plug)

```

yay -Syu vim-plug
ln -sf $PWD/.vimrc ~/.vimrc

```

### Others

```

pacman -Syu neofetch lolcat

```

## Installing web browsers

```

yay -Syu google-chrome
pacman -Syu firefox

```

## libinput gestures

```

yay -S libinput-gestures
ln -sf $PWD/.config/libinput-gestures.conf ~/.config
libinput-gestures-setup autostart start

```

## Development Environment

### VS Code

```

pacman -Syu gnome-keyring
yay -S visual-studio-code-bin

```

### pyenv

```

pacman -Syu pyenv

```

Also the python build dependencies

```

pacman -S --needed base-devel openssl zlib xz

```

And finally,

```

pipenv install 3.9
pipenv install 3.8

```

### Node

```

fisher install jorgebucaran/nvm.fish
nvm install 14

```

## ncspot

Having used `spotify-tui` for a while, ncspot seems easier to set up and use.

```

yay -S ncspot

```

## Other Utilities

```
pacman -Syu ncdu htop discord
```
