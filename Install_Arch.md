# Stepwise Installation guide

This is work in progress. This guide obviously doesn't have everything but should be a pretty good starting point. The script should take care of the rest.

# Initial Setup

## Basic packages

```
pacman -Syu vim nano vi sudo wget curl unzip
```

## User management

```
useradd shashwat -m -G docker,video,storage,input,disk,audio,wheel,adm
passwd shashwat
```

Following this edit the sudoers file to ensure that the users in the wheel group can run commands as the root user.

## Swap file

```
dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
```

## Installing Paru

```
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

## Install a Desktop Environment

```
pacman -Syu xorg-server plasma
```

## Enable Network Manager

```
systemctl enable NetworkManager --now
```

## Installing Bluetooth

```
pacman -Syu bluez bluez-utils
```

Check whether the kernel module is loaded

```
lsmod | grep bluetooth
```

And then start the bluetooth service

```
systemctl enable bluetooth --now
```

## Configuration

Simply run `stow <package_name>` to setup the symlinks.

To configure everything, run

```
stow alacritty fish home kitty tldr libinput lsd ncspot nvim starship
```

# Kernel

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

## Screen Brightness

Add `acpi_backlight=vendor` to the kernel parameters

## USB Auto Suspend

The newer kernels enable this by default. I find it to be quite confusing.

To disable, add `usbcore.autosuspend=-1` to the kernel parameters

# Power Issues

## Suspend

In true NVIDIA fashion, `systemctl suspend` doesn't work if you have Xorg running on the NVIDIA GPU.

To verify, type `nvidia-smi | grep -i xorg`.

One way to solve would to run Xorg on your integrated GPU. I have faced issues doing that in the past, mostly relating to hardware acceleration.

Thus, the fix is to make sure the NVIDIA GPU powers down gracefully.

```
systemctl enable nvidia-suspend
systemctl enable nvidia-hibernate
systemctl enable nvidia-resume
```

I've also noticed that TLP makes suspend not work sometimes. Disabling it fixed the issue.

## Hibernate

Again, blame NVIDIA.

Switching to the LTS Kernel should fix this issue, but presently I have been unable to find a perfect solution for the latest kernel.

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

# Terminal

## Kitty

```
pacman -Syu kitty
```

## Fish

```
pacman -Syu fish fisher
```

## Fonts

```
pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono
```

## LSD

```
pacman -Syu lsd
```

## BAT

```
pacman -Syu bat
```

## Starship prompt

```
pacman -Syu starship
```

## Pokemon colorscripts

```
yay -Syu pokemon-colorscripts-git
```

## Neovim

I use Neovim mostly for quick edits but still have a lot of configuration options.

```
pacman -Syu neovim
yay -Syu neovim-plug
```

Then install all the packages

```
:PlugInstall
```

Following which we need to setup the language servers

```
:CocInstall coc-pyright
:CocInstall coc-css
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

## Docker

```
pacman -Syu docker
```

Docker slows down the boot process considerably, so I start the service before I use it rather than enabling it.

# KVM

Firstly, check if KVM is supported by the processor.

```
LC_ALL=C lscpu | grep Virtualization
```

Then, install the necessary packages

```
pacman -Syu qemu libvirt virt-manager
systemctl enable libvirtd.service --now
```

# Applications

## ncspot

Having used `spotify-tui` for a while, ncspot seems easier to set up and use.

```
yay -S ncspot
```

## Chromium

Out of the box, chromium is almost impossible to use. The following flags fix a host of things

Add the following to `.config/chromium-flags.conf`

```
--ignore-gpu-blocklist
--password-store=basic
--disable-features=UseOzonePlatform
--enable-features=VaapiVideoDecoder
--use-gl=desktop
--enable-gpu-rasterization
--enable-zero-copy
--force-dark-mode
--enable-features=WebUIDarkMode
--profile-directory="Default"
```

## Albert

```
yay -Syu albert-bin
```

## libinput gestures

```
yay -S libinput-gestures
libinput-gestures-setup autostart start
```

## Web browsers

```
pacman -Syu firefox chromium
```

## Flatpak

For certain applications, using flatpak is easier and safer.

```
cat packages/flatpak_packages.txt | xargs flatpak install
```
