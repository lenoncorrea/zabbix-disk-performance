#!/bin/bash

disk=$1
device_model=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep 'Device Model' | cut -f2 -d ":" | awk '{print $1}')
if [[ $device_model == "CT120BX500SSD1" ]] # CRUCIAL BX500 120G
then
  value=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep "Temperature_Celsius" | awk '{print $10}')
  echo $value
  exit
elif [[ $device_model == "CT1000MX500SSD1" ]] # CRUCIAL MX500 1T
then
  value=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep "Temperature_Celsius" | awk '{print $10}')
  echo $value
  exit
elif [[ $device_model == "CT2000MX500SSD1" ]] # CRUCIAL MX500 2T
then
  value=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep "Temperature_Celsius" | awk '{print $10}')
  echo $value
  exit
elif [[ $device_model == "Samsung" ]] # SAMSUNG EVO850 1TB
then
  value=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep "Airflow_Temperature_Cel" | awk '{print $10}')
  echo $value
  exit
else
  echo "Not value for disk"
  exit
fi