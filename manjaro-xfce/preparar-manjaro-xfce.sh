#!/bin/bash

# atualizar sistema
sudo pacman -Syyu
sudo pacman-mirrors -f && sudo pacman -Syyu
sudo pacman -S --noconfirm base-devel
echo 'source "/usr/share/git/completion/git-completion.bash"' >> ~/.bashrc
sudo pacman -S --noconfirm xscreensaver
mkdir -p ~/.config/systemd/user/
cd "$(pwd)" && cp xscreensaver.service ~/.config/systemd/user/xscreensaver.service || exit 1
systemctl --user enable xscreensaver
# Autostart if commands above didn't work
# To launch custom applications when Xfce starts up, click the Applications Menu > Settings > Settings Manager and then
# choose the Session and Startup option and click the tab Application Autostart. You will see a list of programs that
# get launched on startup. To add an entry, click the Add button and fill out the form, specifying the path to an
# executable you want to run.
cd ~ || exit 1
# java
sudo pacman -S --noconfirm jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src
yay -S jre jdk
# R
sudo pacman -S --noconfirm r

# instalar pacotes com snap
sudo pacman -S --noconfirm snapd && sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install pycharm-professional --classic
sudo snap install audacity
sudo snap install bitwarden
sudo snap install code --classic
sudo snap install kate --classic
sudo snap install ksnip

# install Miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
conda update conda
