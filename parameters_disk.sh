#!/bin/bash

first_line=$(smartctl -a /dev/sda | grep -i -n -w "ATTRIBUTE_NAME" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE COMEÇAM PARAMETROS
last_line=$(smartctl -a /dev/sda | grep -i -n -w "SMART Error Log Version" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA ONDE TERMINAM PARAMETROS

for line in $(seq $first_line $last_line)
do 
  echo $line
done

#smartctl -a /dev/sda | head -54 | tail -1 | awk '{print $2}' # DEVOLVE NOME DO ELEMENTE