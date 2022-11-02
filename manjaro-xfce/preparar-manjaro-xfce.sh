#!/bin/bash

# atualizar sistema
sudo pacman -Syyu
sudo pacman-mirrors -f && sudo pacman -Syyu
sudo pacman -S --noconfirm base-devel
echo 'source "/usr/share/git/completion/git-completion.bash"' >> ~/.bashrc
sudo pacman -S --noconfirm redshift
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
# redshift
sudo pacman -Syu --noconfirm redshift
# java
sudo pacman -S --noconfirm jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src
yay -S jre jdk
# R
sudo pacman -S --noconfirm r
yay -S rstudio-desktop-bin
# enable Multicore support
yay -S openblas-lapack
# Troubleshooting R
# Generally, packages for your R software can be installed via the command install.packages() or by using the menu in
# RStudio. Depending on your manjaro installation, some packages can't be installed by default. If you encounter an
# error message saying the command "gfortran" is unknown, then your system is unable to interpret parts of the source
# code. This problem can simply be fixed by installing "gcc-fortran" via your favorite Manjaro package manager
# (e.g. Pamac) or by using the console:
sudo pacman -S noconfirm gcc-fortran
sudo pacman -S noconfirm cmake  
#Most text mining packages in R require rjava, if you receive an error message related to this, run the following
# commands in Konsole or in console of your choice
export JAVA_LIBS="$JAVA_LIBS -ldl"
sudo R CMD javareconf


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
