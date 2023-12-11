# Funcional
- criar arquivo de log
- separar pacman em KDE e XFCE
- herdar funções utilitárias de modo que elas executassem no próprio script, não do módulo original (talvez um source nelas resolva)
- adicionar opção de execução -v (verbose)
# Fix
- git clone em repositório para diretório já existente, remover o antigo e então clonar (yay)
# Estrutura
- considerar usar num módulo separado para as funções utilitárias, e.g, no **kinit.sh** `source ../utils/f_utils`
# Testes
- criar máquina virtual, considerar docker e rodar todos os gerenciadores que utilizo principalmente (apt e pacman)
# Logs
- criar diretório para log
- nome do arquivo com data e horário atualiza_sistema_YYYYMMDD_hhmmss.log
- adicionar cores nos logs
  - sucesso e fracasso
- procura por script pronto de log, facilita
- segregar as mensagens de logs e instalações de pacotes por função