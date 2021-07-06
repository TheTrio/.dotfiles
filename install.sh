PWD=$(pwd)

# getting the latest packages
apt-get update
apt-get upgrade

# VS Code
snap install code --classic

# Discord
snap install discord
snap connect discord:system-observe

# Install better discord
add-apt-repository ppa:chronobserver/betterdiscordctl
apt-get update
apt-get install betterdiscordctl
betterdiscordctl --d-install snap install

# for some odd reason, the snap package for spotifyd didnd't work the last time I tried
# I should however try that before compiling the thing from source
snap install spotifyd
# More about running it as a systemd service here -> https://spotifyd.github.io/spotifyd/config/services/Sytemd.html

# Below are the instructions to build it from source

# apt install rustc cargo libasound2-dev libssl-dev pkg-config
# git clone https://github.com/Spotifyd/spotifyd.git
# cd spotifyd
# cargo build --release
# ./target/release/spotifyd


# Installing spotify TUI(https://github.com/Rigellute/spotify-tui#installation)
snap install spt
# Also before running this make sure to add the username and password in the config file (located ~/.config/spotifyd)


# Oh my posh
# For some reason, python powerline refuses to work anymore. Oh my posh seems like a good alterative
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

# Node Version Manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# setting up the symlinks
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.bash_aliases ~/.bash_aliases
ln -s $PWD/.config/kitty ~/.config
ln -s $PWD/.config/oh_my_posh ~/.config
ln -s $PWD/.config/spotifyd ~/.config
echo "DONE!"
