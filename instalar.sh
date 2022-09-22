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
SUDC="sudo curl -s" 							#Comando para cópia de arquivo
PTMP="https://raw.githubusercontent.com/thespation/BTA-508/firmware/"	#Pasta dos arquivos de firmware
PF1="/lib/firmware/rtl_bt/rtl8761b_fw.bin"				#Pasta e arquivo de firmware
PF2="/lib/firmware/rtl_bt/rtl8761b_config.bin"				#Pasta e arquivo de firmware
PF="/lib/firmware/rtl_bt/"						#Pasta de firmware
ARQ1="rtl8761b_fw"							#Arquivo de firmware 	1
ARQ2="rtl8761b_config"							#Arquivo de firmware 	2
#Alias verificação de kernel
UNA='uname -v'

#Verifica se o kernel é compatível com o firmware
VERIKER () {
	if [[ ${UNA} > "5.7* " ]]; then
	VERINST
	else
		clear; echo -e "\n${VERM}[!] Kernel não compatível, para instalar é necessário que seja 5.8* ou superior\n" ${NORM} #Notifica em caso de falha
	fi
}

#Verifica se existe os arquivos de firmware na pasta lib/firmware/rtl_bt/
VERINST () {
	if [[ -f ${PF1} && ${PF2} ]]; then #Verifica se existe arquivos de firmware
		clear; echo -e "\n${CIAN}[ ] Arquivos estão na pasta, não foi necessário modificar\n" ${NORM}
	elif [[ ! -f ${PF1} && ${PF2} ]]; then #Segue instalação
		COPIMEN
	else
		echo -e "\n${VERM}[!] Não foi possível copiar os arquivos\n" ${NORM} #Notifica em caso de falha
	fi	
}

#Copiar arquivos para pasta correta
COPIMEN () {
		echo -e "\n${CIAN}[ ] Copiar arquivos para a pasta" ${NORM} &&
		sudo mkdir -p ${PF} && ${SUDC} ${PTMP}${ARQ1} -o ${PF1}; ${SUDC} ${PTMP}${ARQ2} -o ${PF2} && #Copia os arquivos de firmware 
		echo -e "\n${VERD}[*] Arquivos acrescentados à pasta, reinicie a máquina para que funcione corretamente" ${NORM}
}
# Iniciar o processo de verificação e instalação
clear; VERIKER
