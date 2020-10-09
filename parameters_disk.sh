#!/bin/bash

disks=$(sudo lsblk -dp | grep -o '^/dev[^ ]*' | cut -f3 -d "/")
for disk in $disks
do
# disk=$1
first_line=$(sudo smartctl -a /dev/$disk | grep -i -n -w "ATTRIBUTE_NAME" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE COMEÇAM PARAMETROS
first_line=$(($first_line+1)) # AJUSTA PARA PEGAR PRIMEIRO PARAMETRO
last_line=$(sudo smartctl -a /dev/$disk | grep -i -n -w "SMART Error Log Version" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE TERMINAM PARAMETROS
last_line=$(($last_line-2)) # AJUSTA PARA REMOVER LINHAS EM BRANCO
device_model=$(sudo smartctl -a /dev/sda | grep 'Device Model' | cut -f2 -d ":")
serial_number=$(smartctl -a /dev/sda | grep 'Serial Number' | cut -f2 -d ":")
disk_capacity=$(sudo smartctl -a /dev/sda | grep 'User Capacity' | cut -f2 -d ":" | cut -f2 -d "[" | cut -f1 -d "]")

for line in $(seq $first_line $last_line)
do 
  elements=$(sudo smartctl -a /dev/$disk | head -$line | tail -1 | awk '{print $2}') # DEVOLVE NOME DO ELEMENTO
  data="$data,"'{"{#PARAMETER}":"'$elements'"}'
done

echo '{"data":[{"{#DISK}":"'$disk'"},{"{#MODEL}": "'$device_model'"},{"{#SERIAL}": "'$serial_number'"},{"{#CAPACITY}": "'$disk_capacity'"},'${data#,}']}'
done