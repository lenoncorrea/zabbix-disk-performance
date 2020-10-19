#!/bin/bash
while read line
do
  disk=$line
  first_line=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep -i -n -w "ATTRIBUTE_NAME" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE COMEÇAM PARAMETROS
  first_line=$(($first_line+1)) # AJUSTA PARA PEGAR PRIMEIRO PARAMETRO
  last_line=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep -i -n -w "SMART Error Log Version" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE TERMINAM PARAMETROS
  last_line=$(($last_line-2)) # AJUSTA PARA REMOVER LINHAS EM BRANCO
  device_model=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep 'Device Model' | cut -f2 -d ":")
  serial_number=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep 'Serial Number' | cut -f2 -d ":")
  disk_capacity=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep 'User Capacity' | cut -f2 -d ":" | cut -f2 -d "[" | cut -f1 -d "]")

  for line in $(seq $first_line $last_line)
  do 
    elements=$(sudo smartctl -a /dev/$disk | head -$line | tail -1 | awk '{print $2}') # DEVOLVE NOME DO ELEMENTO
    value=$(sudo smartctl -a /dev/"$disk" | grep "$elements" | awk '{print $10}') # DEVOLVE VALOR DO ELEMENTO
    data="$data,"'{"{#PARAMETER}":"'$elements'"}'
  done
  echo '{"data":[{"disco": [{"{#DISK}":"'$disk'"},{"{#MODEL}": "'$device_model'"},{"{#SERIAL}": "'$serial_number'"},{"{#CAPACITY}": "'$disk_capacity'"},]},{"parameters": ['${data#,}']}]}' > /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/$disk
done < /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/disks.txt