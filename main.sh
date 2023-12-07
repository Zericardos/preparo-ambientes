#!/bin/bash
# Código de cores
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# utils
pecho(){
  local msg="$1"
  case "$2" in
    "WARNING")
      local level_msg="$2"
      local level_color="$RED";;
    *)
      local level_msg="INFO"
      local level_color="$YELLOW";;
  esac
  if [ -z "$3" ]; then
    local color_msg="$NORMAL"
  else
    local color_msg="$3"
  fi
  printf "%(%Y-%m-%d %H:%M:%S)T---${level_color}$level_msg${NORMAL}: ${color_msg}${msg}${NORMAL}\n"
}

cd_local_script(){
  local SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  cdm "$SCRIPT_DIR"
  echo "$SCRIPT_DIR"
}

export -f pecho cdm cd_local_script

cdm(){
  cd "$1" || { pecho "The directory $1 doesn’t exist. Exiting. "; exit 1; }
}

install_with_pacman() {
    pecho "Gerenciando sistema com Pacman..."
    bash ./install/pacman_install.sh
}


install_with_apt() {
    pecho "Gerenciando sistema com APT..."
    ./install/apt_install.sh
}


install_with_yum() {
    pecho "Gerenciando sistema com YUM..."
    ./install/yum_install.sh
}


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cdm "$SCRIPT_DIR"
if command -v pacman &> /dev/null; then
    install_with_pacman
#elif command -v apt-get &> /dev/null; then
#    install_with_apt
# Verifica se o YUM (Red Hat/Fedora) está disponível
#elif command -v yum &> /dev/null; then
#    install_with_yum

else
    echo "Nenhum dos gerenciadores de pacotes conhecidos foi encontrado."
    exit 1
fi
