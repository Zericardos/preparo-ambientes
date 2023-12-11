#!/bin/bash
set -o errexit

pacman_install(){
  local package="$1"
  sudo pacman -S --noconfirm "$package" || pecho "O pacote $package não foi instalado" "WARNING"
}

cd_local_script(){
  local SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  cdm "$SCRIPT_DIR"
  echo "$SCRIPT_DIR"
}

atualizar_sistema(){
  exec_cmd "cd_local_script"
  exec_cmd "sudo pacman -Syyu" "Atualizando sistema"
  pecho "imedatectl set-ntp true" "Atualizando data e hora"
  pecho "sudo pacman-mirrors -f && sudo pacman -Syyu" "Atualizando repositórios"
  pecho "sudo pacman -S --noconfirm base-devel" "Atualizando todos os componentes base"
  exec_cmd "source /usr/share/git/completion/git-completion.bash >> $HOME/.bashrc" "Adicionando autocomplete do git ao bash"
#  exec_cmd "source /usr/share/git/completion/git-completion.zsh >> $HOME/.zshrc" "Adicionando autocomplete do git ao zsh"
  pecho "Iniciando instalação de utilitários"
  exec_cmd "sudo pacman -S --noconfirm audacity" "Instalando Audacity"
  #  exec_cmd "sudo pacman -S --noconfirm redshift"
  exec_cmd "sudo pacman -S --noconfirm xscreensaver" "Instalando Xscreensaver"
  exec_cmd "mkdir -p $HOME/.config/systemd/user/"
  exec_cmd "cd_local_script && cp xscreensaver.service $HOME/.config/systemd/user/xscreensaver.service || exit 1"
  exec_cmd "systemctl --user enable xscreensaver"
  # Autostart if commands above didn't work
  # To launch custom applications when Xfce starts up, click the Applications Menu > Settings > Settings Manager and then
  # choose the Session and Startup option and click the tab Application Autostart. You will see a list of programs that
  # get launched on startup. To add an entry, click the Add button and fill out the form, specifying the path to an
  # executable you want to run.
  # redshift
  #sudo pacman -Syu --noconfirm redshift
  pecho "Iniciando instalação de programação"
  exec_cmd "sudo pacman -S --noconfirm jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src" "Instalando Java" "sudo pacman -Sy --noconfirm jdk-openjdk && sudo pacman -Su"
  pecho "Instalar YAY"
  exec_cmd "sudo pacman -S --noconfirm go" "Instalando pacote de linguagem Go"
  exec_cmd "git clone https://aur.archlinux.org/yay.git $HOME/yay/" "Baixando repositório yay"
  cdm "$HOME/yay"
  exec_cmd "sudo -u $(whoami) makepkg -si" "Compilando e instalando o programa YAY"
  exec_cmd "makepkg -si --noconfirm"
  exec_cmd "cd .."
  exec_cmd "rm -vrf yay"
  exec_cmd "yay -S jre jdk"
  exec_cmd "sudo pacman -S --noconfirm r" "Instalando o software R"
  exec_cmd "yay -S rstudio-desktop-bin" "Instalando o Rstudio"
  exec_cmd "yay -S openblas-lapack" "Habilitando suporte Multicore"
  # Troubleshooting R
  # Generally, packages for your R software can be installed via the command install.packages() or by using the menu in
  # RStudio. Depending on your manjaro installation, some packages can't be installed by default. If you encounter an
  # error message saying the command "gfortran" is unknown, then your system is unable to interpret parts of the source
  # code. This problem can simply be fixed by installing "gcc-fortran" via your favorite Manjaro package manager
  # (e.g. Pamac) or by using the console:
  pecho "Instalando pacotes adicionais para o R"
  exec_cmd "sudo pacman -S --noconfirm gcc-fortran"
  exec_cmd "sudo pacman -S --noconfirm cmake"
   #Most text mining packages in R require rjava, if you receive an error message related to this, run the following
   # commands in Konsole or in console of your choice
  exec_cmd "export JAVA_LIBS=$JAVA_LIBS -ldl"  #parece não funcionar com KDE Plasma! Separar
  exec_cmd "sudo R CMD javareconf"
   # install lib for rstudio
  exec_cmd "sudo pacman -S --noconfirm openssl-1.1"
  exec_cmd "pamac install xclip" "Instalando xclip"
  pecho "Instalar pacotes com Snap"
  exec_cmd "sudo pacman -S --noconfirm snapd && sudo systemctl enable --now snapd.socket" "Instalando Snap"
  exec_cmd "sudo ln -s /var/lib/snapd/snap /snap"
  exec_cmd "sudo snap install pycharm-community --classic" "Instalando pycharm"
  exec_cmd "sudo snap install bitwarden" "Instalando Bitwarden"
  exec_cmd "sudo snap install code --classic" "Instalando VSCode"
  exec_cmd "sudo snap install kate --classic" "Instalando Kate"
  exec_cmd "sudo snap install ksnip" "Instalando Ksnip"
  pecho "Instalando última versão do Miniconda"
  exec_cmd "mkdir -p $HOME/miniconda3"
  exec_cmd "wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda3/miniconda.sh"
  exec_cmd "bash $HOME/miniconda3/miniconda.sh -b -u -p $HOME/miniconda3"
  exec_cmd "rm -rf $HOME/miniconda3/miniconda.sh"
  exec_cmd "$HOME/miniconda3/bin/conda init bash"
  exec_cmd "$HOME/miniconda3/bin/conda init zsh"
  exec_cmd "conda update conda"
  exec_cmd "sudo pamac build google-chrome" "Instalando Google Chrome"
  pecho "Sistema preparado com sucesso!"
}
atualizar_sistema | tee -a log_execucao.log
