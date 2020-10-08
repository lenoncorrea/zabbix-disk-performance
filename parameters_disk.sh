#!/bin/bash

first_line=$(smartctl -a /dev/sda | grep -i -n -w "ATTRIBUTE_NAME" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE COMEÇAM PARAMETROS
last_line=$(smartctl -a /dev/sda | grep -i -n -w "SMART Error Log Version" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE TERMINAM PARAMETROS
last_line=$(($last_line-2))

for line in $(seq $first_line $last_line)
do 
  element=$(smartctl -a /dev/sda | head -$line | tail -1 | awk '{print $2}') # DEVOLVE NOME DO ELEMENTO
  echo $element
done

