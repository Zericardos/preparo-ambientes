#!/bin/bash

# atualizar sistema
sudo pacman -Syyu
sudo pacman -S xscreensaver

# instalar com snap
sudo pacman -S snapd && sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install pycharm-professional --classic
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

