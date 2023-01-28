# Stepwise Installation guide

Just so that I can copy paste commands while trying to set up a new device. A lot of this stuff is automated by the install script, but I still try and keep this detailed so that if and when the script does fail, I can manually setup everything.

This guide gets outdated pretty fast given I experiment a lot with my setup, so things might not work as expected.

## Initial Setup

### Basic packages

```bash
pacman -Syu vim nano vi sudo wget curl unzip
```

### User management

```bash
useradd shashwat -m -G docker,video,storage,input,disk,audio,wheel,adm
passwd shashwat
```

Following this edit the sudoers file to ensure that the users in the wheel group can run commands as the root user.

### Swap file

```bash
dd if=/dev/zero of=/swapfile bs=1G count=4 status=progress
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
```

### Installing Paru

```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### Install a Desktop Environment

```bash
pacman -Syu xorg-server plasma plasma-wayland-session
```

### Enable Network Manager

```bash
systemctl enable NetworkManager --now
```

### Setting up a firewall

I use [`ufw`](https://wiki.archlinux.org/title/Uncomplicated_Firewall).

```bash
pacman -Syu ufw
systemctl enable ufw --now
ufw default deny
ufw allow 1714:1764/udp
ufw allow 1714:1764/tcp
ufw allow qBittorrent
ufw reload
```

The rules for ports 1714 to 1764 are for making sure [KDE Connect](https://userbase.kde.org/KDEConnect#I_have_two_devices_running_KDE_Connect_on_the_same_network.2C_but_they_can.27t_see_each_other) works.

### Installing Bluetooth

```bash
pacman -Syu bluez bluez-utils
```

Check whether the kernel module is loaded

```bash
lsmod | grep bluetooth
```

And then start the bluetooth service

```bash
systemctl enable bluetooth --now
```

In order to make the touch controls to work on Sony headphones, enable the mpris service

```
systemctl enable mpris-proxy.service --now --user
```

## Configuration

Simply run `stow <package_name>` to setup the symlinks.

To configure everything, run

```bash
stow alacritty fish home kitty tldr libinput lsd ncspot nvim starship mpris
```

## Kernel

### Ethernet module

I've had much better luck with the [r8168](https://archlinux.org/packages/community/x86_64/r8168/) kernel module than r8169, which is the one included by default

Firstly, check which kernel driver is in use

```bash
lspci -v | grep ethernet -i -A 9
```

Its probably r8169. Install r8168 and add r8169 to the blocklist

```bash
pacman -Syu r8168
echo "blacklist r8169" >> /etc/modprobe.d/blacklist.conf
```

### Webcam module

I prefer to have the laptop webcam disabled for privacy reasons. Run the following to add the necessary kernal module to the blocklist

```bash
echo "blacklist uvcvideo" >> /etc/modprobe.d/blacklist.conf
```

To enable the camera temporarily, do

```bash
modprobe uvcvideo
```

Similarly, to disable it temporarily, do

```bash
modprobe -r uvcvideo
```

### Screen Brightness

Add `acpi_backlight=vendor` to the kernel parameters

### USB Auto Suspend

The newer kernels enable this by default. I find it to be quite confusing.

To disable, add `usbcore.autosuspend=-1` to the kernel parameters

## Power Issues

### Suspend

In true NVIDIA fashion, `systemctl suspend` doesn't work if you have Xorg running on the NVIDIA GPU.

To verify, type `nvidia-smi | grep -i xorg`.

One way to solve would to run Xorg on your integrated GPU. I have faced issues doing that in the past, mostly relating to hardware acceleration.

Thus, the fix is to make sure the NVIDIA GPU powers down gracefully.

```bash
systemctl enable nvidia-suspend
systemctl enable nvidia-hibernate
systemctl enable nvidia-resume
```

I've also noticed that TLP makes suspend not work sometimes. Disabling it fixed the issue.

### Hibernate

Again, blame NVIDIA.

Switching to the LTS Kernel should fix this issue, but presently I have been unable to find a perfect solution for the latest kernel.

## Enabling hardware acceleration

```bash
pacman -Syu xf86-video-amdgpu vulkan-radeon libva-mesa-driver mesa-vdpau mesa
```

With firefox, follow the [Arch Wiki guide](https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration)

## GPU drivers

Run the following to get the current drivers

```bash
lspci -k | grep -A 2 -E "(VGA|3D)"
```

Install proprietary nvidia drivers with

```bash
pacman -Syu nvidia nvidia-prime
```

## Terminal

### Terminal Emulators

```bash
pacman -Syu wezterm kitty
```

### Fish

```bash
pacman -Syu fish fisher
```

#### Plugins

```fish
fisher install jorgebucaran/nvm.fish
fisher install dracula/fish
```

### RVM

```fish
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
```

### Fonts

```bash
pacman -S noto-fonts noto-fonts-emoji noto-fonts-cjk ttf-jetbrains-mono
```

### LSD

```bash
pacman -Syu lsd
```

### BAT

```bash
pacman -Syu bat
```

### Starship prompt

```bash
pacman -Syu starship
```

### Neovim

I use Neovim mostly for quick edits but still have a lot of configuration options.

```bash
pacman -Syu neovim
yay -Syu neovim-plug
```

Then install all the packages

```bash
:PlugInstall
```

Following which we need to setup the language servers

```bash
:CocInstall coc-pyright
:CocInstall coc-css
```

## Development Environment

### VS Code

```bash
pacman -Syu gnome-keyring
yay -S visual-studio-code-bin icu69-bin
```

### Window Tiling

I keep this ignore list around to make sure that I don't accidentally tile a window that I don't want to.

```text
systemsettings,xdg-desktop-portal-kde,org.freedesktop.impl.portal.desktop.kde,org.kde.polkit-kde-authentication-agent-1
```

### pyenv

```bash
pacman -Syu pyenv
```

Also the python build dependencies

```bash
pacman -S --needed base-devel openssl zlib xz
```

And finally,

```bash
pyenv install 3.10
pyenv install 3.9
```

### Docker

```bash
pacman -Syu docker
```

Docker slows down the boot process considerably, so I start the service before I use it rather than enabling it.

## KVM

Firstly, check if KVM is supported by the processor.

```bash
LC_ALL=C lscpu | grep Virtualization
```

Then, install the necessary packages

```bash
pacman -Syu qemu libvirt virt-manager
systemctl enable libvirtd.service --now
```

## Applications

### ncspot

Having used `spotify-tui` for a while, ncspot seems easier to set up and use.

```bash
yay -S ncspot
```

### Chromium

Out of the box, chromium is almost impossible to use. The following flags fix a host of things

Add the following to `.config/chromium-flags.conf`

```bash
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

### libinput gestures

```bash
yay -S libinput-gestures
libinput-gestures-setup autostart start
```
