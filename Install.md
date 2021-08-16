## Step Wise Installation Guide

The unguided installer does work most of the time, but it can also break quite easily. Which is why I'm writing this guide for myself

### Update the system

```
apt-get update
apt-get upgrade
```

### Install curl and wget

```
apt-get install curl wget -y
```

### Install Vim and its plugins

The following plugins are installed by default

1. [joshdick/onedark.vim](https://github.com/joshdick/onedark.vim)
2. [itchyny/lightline.vim](https://github.com/itchyny/lightline.vim)
3. [preservim/nerdtree](https://github.com/preservim/nerdtree)
4. [ryanoasis/vim-devicons](https://github.com/ryanoasis/vim-devicons)

The Plugin manager I use is [Vim Plug](https://github.com/junegunn/vim-plug)

```
apt-get install vim -y
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -s $PWD/.vimrc ~/.vimrc
```

Then run `:PlugInstall` in vim

### Install VS Code

```
snap install code --classic
```

### Install flameshot

```
apt-get install flameshot -y
```

### Install discord and Better Discord

```
snap install discord
snap connect discord:system-observe

add-apt-repository ppa:chronobserver/betterdiscordctl -y
apt-get update
apt-get install betterdiscordctl -y
betterdiscordctl --d-install snap install
```

### Install Spotifyd and SPT

Unfortunately, this is a bit more complicated than the others. The snap package doesn't work for me and the released binaries don't either. I've had to compile the whole thing myself, and fortunately, that did fix the problem. However, to save myself from compiling the thing every single time, I've added a release on Github itself.

```
curl https://github.com/TheTrio/.dotfiles/releases/download/1/spotifyd -o ~/Downloads/spotifyd
cp ~/Downloads/spotifyd /usr/bin/
chmod +x /usr/bin/spotifyd
mkdir ~/.config/systemd/user/ -p
cp $PWD/spotifyd.service ~/.config/system/user/
mkdir ~/.config/spotifyd
cp $PWD/.config/spotifyd/spotifyd.conf ~/.config/spotifyd/spotifyd.conf

systemctl --user start spotifyd.service
systemctl --user enable spotifyd.service

snap install spt

cp $PWD/.config/spotify-tui/config.yaml ~/snap/spt/current/.config/spotify-tui/
```

Before starting SPT remember to enter your username and password in the `spotifyd.conf` file

### Install Kitty

The Kitty package in the Ubuntu 20.04 repos is seriously outdated. Which is why I'm using curl instead.

```
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# Update the path to the kitty icon in the kitty.desktop file
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g"  \
    ~/.local/share/applications/kitty.desktop
```

Now installing my config files for kitty

```
rm -rf ~/.config/kitty
ln -s $PWD/.config/kitty ~/.config
```

### Install Nerd Fonts

1. JetBrains Mono

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
```

2. Meslo LGM Nerd Font

```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip -O ~/Downloads/Meslo.zip
find . -name "*Complete.ttf" -delete
find . -name "*Windows*" -delete
cp *.ttf /usr/share/fonts/
fc-cache -fv
```

### Installing Oh My Posh

```
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

ln -s $PWD/.config/oh_my_posh ~/.config
```

### Setting up the shells

1. Bash

```
rm ~/.bashrc
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.bash_aliases ~/.bash_aliases
```

2. Fish

```
apt-add-repository ppa:fish-shell/release-3 -y
apt-get update
apt-get install fish -y
ln -s $PWD/.config/fish/config.fish ~/.config/fish/
```

Now install fisher

```
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
```

and Node version manager

```
fisher install jorgebucaran/nvm.fish
```

Setting default shell as fish

```
chsh -s /usr/bin/fish
```

### Setting up LibInput gestures

```
gpasswd -a $USER input
apt-get install wmctrl xdotool libinput-tools build-essential -y
git clone https://github.com/bulletmark/libinput-gestures.git
cd libinput-gestures
make install
cd ..
rm -rf libinput-gestures
ln -s $PWD/.config/libinput-gestures.conf ~/.config
```

After restarting(or logging out), enter the following command

```
libinput-gestures-setup autostart start
```

### LSD

```
wget https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd-musl_0.20.1_amd64.deb -O lsd.deb
dpkg -i lsd.deb
rm lsd.deb
ln -s $PWD/.config/lsd ~/.config
```

### Pop Shell

```
apt-get install node-typescript make git -y
git clone https://github.com/pop-os/shell
cd shell
make local-install
cd ..
rm -rf shell
```

### GNOME Extensions

1. [Hide Top Bar](https://extensions.gnome.org/extension/545/hide-top-bar/)
2. [Panel OSD](https://extensions.gnome.org/extension/708/panel-osd/)
3. [Workspace Matrix](https://extensions.gnome.org/extension/1485/workspace-matrix/)
4. [Blur My Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
5. [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
6. [Hide Top Bar](https://extensions.gnome.org/extension/545/hide-top-bar/)
