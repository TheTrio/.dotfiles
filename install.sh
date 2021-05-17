PWD=$(pwd)

# getting the latest packages
apt-get update
apt-get upgrade

# installing my packages
apt-get install < packages_list.txt

# installing snap packages

# Spotify
sudo snap install spotify

# VS Code
sudo snap install code --classic

# installing VS Code extensions
code --install-extension CoenraadS.bracket-pair-colorizer
code --install-extension DigitalBrainstem.javascript-ejs-support
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension zhuangtongfa.material-theme

# Discord
sudo snap install discord
snap connect discord:system-observe


# Oh my posh
# For some reason, python powerline refuses to work anymore. Oh my posh seems like a good alterative
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

# setting up the symlinks
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.bash_aliases ~/.bash_aliases
ln -s $PWD/.config/kitty ~/.config
ln -s $PWD/.config/oh_my_posh ~/.config
echo "DONE!"