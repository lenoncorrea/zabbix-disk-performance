#!/bin/bash

line=$(smartctl -a /dev/sda | grep -i -n -w "ATTRIBUTE_NAME" | cut -f1 -d ":") # DEVOLVE NUMERO DA LINHA: 53

echo $line