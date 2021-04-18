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


# Installing powerline
pip3 install --user powerline-status
pip3 install powerline-gitstatus

# setting up the symlinks
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.bash_aliases ~/.bash_aliases
ln -s $PWD/.config/kitty ~/.config
ln -s $PWD/.config/powerline/ ~/.config/

echo "DONE!"