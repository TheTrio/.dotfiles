# Stepwise Installation guide

This is work in progress. This guide obviously doesn't have everything but should be a pretty good starting point. The script should take care of the rest

# Install the essentials

```
pacman -Syu vim nano vi sudo wget curl unzip
```

# User management

```
useradd shashwat -m -G wheel,input,disk,audio,video,storage
passwd shashwat
```

Following this editor the sudoers file to ensure that the users in the wheel group can run commands as the root user.

# Swap file

```
dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
sudo echo "/swapfile none swap defaults 0 0" >> /etc/fstab
```

# Installing Yay

```
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
```

# Install a Desktop Environment

```
pacman -Syu xorg-server plasma sddm
systemctl enable sddm
reboot
```

# Enable Network Manager

```
systemctl enable NetworkManager
systemctl start NetworkManager
```

# Installing Bluetooth

```
pacman -Syu bluez bluez-utils
```

Check whether the kernel module is loaded

```
lsmod | grep bluetooth
```

And then start the bluetooth service

```
sudo systemctl enable bluetooth --now
```

# Kernal

## Ethernet module

I've had much better luck with the [r8168](https://archlinux.org/packages/community/x86_64/r8168/) kernel module than r8169, which is the one included by default

Firstly, check which kernel driver is in use

```
lspci -v | grep ethernet -i -A 9
```

Its probably r8169. Install r8168 and add r8169 to the blocklist

```
pacman -Syu r8168
echo "blacklist r8169" >> /etc/modprobe.d/blacklist.conf
```

## Webcam module

I prefer to have the laptop webcam disabled for privacy reasons. Run the following to add the necessary kernal module to the blocklist

```
echo "blacklist uvcvideo" >> /etc/modprobe.d/blacklist.conf
```

To enable the camera temporarily, do

```
modprobe uvcvideo
```

Similarly, to disable it temporarily, do

```
modprobe -r uvcvideo
```

## Hibernation

Details [here](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate#Hibernation_into_swap_file)

```
findmnt -no UUID -T /swapfile
sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
```

After finding the `UUID` and the `offset` of `/swapfile`, add the following kernel parameters

```
resume=UUID=THE_UUID resume_offset=THE_OFFSET
```

## Screen Brightness

Add `acpi_backlight=vendor` to the kernel parameters

## USB Auto Suspend

The newer kernels enable this by default. I find it to be quite confusing.

To disable, add `usbcore.autosuspend=-1` to the kernel parameters

# Install Kitty

```
pacman -Syu kitty
ln -sf $PWD/.config/kitty ~/.config
```

# Configure shells

## Fish

```
pacman -Syu fish
ln -sf $PWD/.config/fish/config.fish ~/.config/fish/
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

## Bash

```
ln -sf $PWD/.bashrc ~/.bashrc
ln -sf $PWD/.bash_aliases ~/.bash_aliases
```

# Enabling hardware acceleration

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

# Installing essential KDE Applications

```
pacman -S gwenview kwalletmanager kwallet partitionmanager dolphin
```

# Making the terminal look pretty

## Fonts

```
sudo pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono
```

## LSD

```
pacman -Syu lsd
ln -sf $PWD/.config/lsd ~/.config
```

## BAT

```
pacman -Syu bat
```

## Oh my posh

Recently, I've started using the starship prompt, but I'll keep this here just in case I change my mind

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

## Starship prompt

```
pacman -Syu starship
```

## Pokemon colorscripts

```
git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
cd pokemon-colorscripts/
sudo ./install.sh
```

## Vim Plugins

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

## Others

```
pacman -Syu neofetch lolcat
```

# Installing web browsers

```
yay -Syu google-chrome
pacman -Syu firefox
```

# libinput gestures

```
yay -S libinput-gestures
ln -sf $PWD/.config/libinput-gestures.conf ~/.config
libinput-gestures-setup autostart start
```

# Development Environment

## VS Code

```
pacman -Syu gnome-keyring
yay -S visual-studio-code-bin
```

## pyenv

```
pacman -Syu pyenv
```

Also the python build dependencies

```
pacman -S --needed base-devel openssl zlib xz
```

And finally,

```
pyenv install 3.10
pyenv install 3.9
```

## Node

```
fisher install jorgebucaran/nvm.fish
nvm install 14
```

## Insomnia

```
yay -Syu insomnia-bin
```

# ncspot

Having used `spotify-tui` for a while, ncspot seems easier to set up and use.

```
yay -S ncspot
```

# Discord

```
pacman -Syu discord
```

Discord, or rather Chromium does have some issues with hardware acceleration by default so we have to manually enable some flags

Add the following to the `discord.desktop` file, probably located in `/usr/share/applications`

```
Exec=/usr/bin/discord --ignore-gpu-blocklist --disable-features=UseOzonePlatform --enable-features=VaapiVideoDecoder --use-gl=desktop --enable-gpu-rasterization --enable-zero-copy
```

Use the same flags for Google Chrome

# Other Utilities

```
pacman -Syu ncdu htop ulauncher
```
