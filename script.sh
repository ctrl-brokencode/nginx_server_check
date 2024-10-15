#!/bin/sh

### Definição de Variáveis

# Variáveis Iniciais
hour=$(date +"%H")
get_status=$(systemctl is-active nginx)
service="NGINX"

# Validação de hora
if [ $hour -ge 18 ] && [ $hour -lt 24 ]
then
	cumprimento="Boa noite!"
elif [ $hour -ge 12 ]
then
	cumprimento="Boa tarde!"
elif [ $hour -ge 6 ]
then
	cumprimento="Bom dia!"
elif [ $hour -ge 0 ]
then
	cumprimento="Boa madrugada!"
fi

# Status do Serviço
if [ $get_status = "active" ]
then
	status="ONLINE"
else
	status="OFFLINE"
fi

# Criação dos Arquivos
if [ $status = "ONLINE" ]
then
	echo "\n$(date +'%d/%m/%Y %H:%M') - $cumprimento\n"\
	"- Serviço: $service\n"\
	"- Status: $status\n"\
	"O serviço está em execução!" >> online.log
else
	echo "\n$(date +'%d/%m/%Y %H:%M') - $cumprimento\n"\
	"- Serviço: $service\n"\
	"- Status: $status\n"\
	"O serviço está fora do ar." >> offline.log
fi

echo "$(date +'%d/%m/%Y %H:%M') - $cumprimento\n"\
"- Serviço: $service\n"\
"- Status: $status\n" >> geral.log
