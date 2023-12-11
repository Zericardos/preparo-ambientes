#!/bin/bash
# Código de cores

# utils
pecho(){
  declare -A arr_cores
  arr_cores[BLACK]=$(tput setaf 0)
  arr_cores[RED]=$(tput setaf 1)
  arr_cores[GREEN]=$(tput setaf 2)
  arr_cores[YELLOW]=$(tput setaf 3)
  arr_cores[LIME_YELLOW]=$(tput setaf 190)
  arr_cores[POWDER_BLUE]=$(tput setaf 153)
  arr_cores[BLUE]=$(tput setaf 4)
  arr_cores[MAGENTA]=$(tput setaf 5)
  arr_cores[CYAN]=$(tput setaf 6)
  arr_cores[WHITE]=$(tput setaf 7)
  arr_cores[BRIGHT]=$(tput bold)
  arr_cores[NORMAL]=$(tput sgr0)
  arr_cores[BLINK]=$(tput blink)
  arr_cores[REVERSE]=$(tput smso)
  arr_cores[UNDERLINE]=$(tput smul)
  local msg="$1"
  case "$2" in
    "WARNING")
      local level_msg="$2"
      local level_color="${arr_cores[LIME_YELLOW]}";;
    "ERROR")
      local level_msg="$2"
      local level_color="${arr_cores[RED]}";;
    "SUCCESS")
      local level_msg="$2"
      local level_color="${arr_cores[GREEN]}";;
    *)
      local level_msg="INFO"
      local level_color="${arr_cores[YELLOW]}";;
  esac
  if [ -z "$3" ]; then
    local color_msg="${arr_cores[NORMAL]}"
  else
    local color_msg="$3"
  fi
  printf "%(%Y-%m-%d %H:%M:%S)T---${level_color}$level_msg${arr_cores[NORMAL]}: ${color_msg}${msg}${arr_cores[NORMAL]}\n"
}

exec_cmd(){
  local cmd="$1"
  pecho "$2"
  if eval "$cmd"; then
    pecho "O comando '$cmd' foi executado com sucesso" "SUCCESS"
  else
    pecho "O comando '$cmd' não foi executado com sucesso" "ERROR"
    if [ -n "$3" ]; then
      eval "$3"
    else
      return 1
    fi
fi
}



cd_local_script(){
  local SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
  cdm "$SCRIPT_DIR"
  echo "$SCRIPT_DIR"
}

cdm(){
  cd "$1" || { pecho "The directory $1 doesn’t exist. Exiting. "; exit 1; }
}

export arr_cores
export -f pecho cdm exec_cmd


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
