#!/usr/bin/env bash
# Desenvolvido pelo William Santos
# contato: thespation@gmail.com ou https://github.com/thespation /
# Motivação: https://plus.diolinux.com.br/t/review-adaptador-bluetooth-orico-bta-508-no-linux/35393

# Cores (tabela de cores: https://gist.github.com/avelino/3188137)
VERM="\033[1;31m"	#Deixa a saída na cor vermelho
VERD="\033[0;32m"	#Deixa a saída na cor verde
CIAN="\033[0;36m"	#Deixa a saída na cor ciano
NORM="\033[0m"		#Volta para a cor padrão
# Alias firmware
SUDC='sudo cp -iv' 									#Comando para cópia de arquivo
PTMP='/tmp/BTA-508/20201202_LINUX_BT_DRIVER/rtkbt-firmware/lib/firmware/rtlbt/'		#Pasta temporária
PF1='/lib/firmware/rtl_bt/rtl8761b_fw.bin'						#Pasta e arquivo de firmware
PF2='/lib/firmware/rtl_bt/rtl8761b_config.bin'						#Pasta e arquivo de firmware
ARQ1='rtl8761b_fw'									#Arquivo de firmware 	1
ARQ2='rtl8761b_config'									#Arquivo de firmware 	2
#Alias verificação de kernel
UNA='uname -v'

#Verifica se existe os arquivos, caso não exista copia para as pastas corretas
VERINST () {
	if [[ -e ${PF1} && ${PF2} ]]; then #Verifica se existe arquivos de firmware
		clear; echo -e "\n${CIAN}[ ] Arquivos estão nas pasta, não foi necessário modificar\n" ${NORM}
		
	elif [[ ! -e ${PF1} && ${PF2} ]]; then #Segue instalação
		cd /tmp/BTA-508 &&
		echo -e "\n${CIAN}[ ] Descompactando arquivo" ${NORM} &&
		7z x 20201202_mpow_BH456A_driver+for+Linux.7z &&
		echo -e "\n${VERD}[*] Arquivo descompactado" ${NORM} &&
		echo -e "\n${CIAN}[ ] Copiando arquivos para as pastas" ${NORM} &&
		${SUDC} ${PTMP}${ARQ1} ${PF1}; ${SUDC} ${PTMP}${ARQ2} ${PF2}
		echo -e "\n${VERD}[*] Arquivos enviados às pastas, reinicie a máquina para que funcione corretamente" ${NORM}
	else
		echo -e "\n${VERM}[!] Não foi possível copiar os arquivos\n" ${NORM} #Notifica em caso de falha
	fi	
}
#Verifica se o kernl é compatível com o firmware
VERIKER () {
	if [[ ${UNA} != "5.7* " ]]; then
	VERINST
	else
		clear; echo -e "\n${VERM}[!] Kernel não compatível, para instalar é necessário que seja 5.8* ou superior\n" ${NORM} #Notifica em caso de falha
	fi
}
# Iniciar o processo de verificação e instalação de ícones
VERIKER
