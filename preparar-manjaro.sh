#!/bin/bash

sudo pacman -Syyu # atualizar sistema
sudo pacman -S snapd && sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install pycharm-professional --classic
sudo pacman -S xscreensaver