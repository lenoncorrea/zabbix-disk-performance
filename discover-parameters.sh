#!/bin/bash

disk=$1
device_model=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep 'Device Model' | cut -f2 -d ":" | awk '{print $1}')
if [[ $device_model == "KINGSTON" ]]
then
  value=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep "SSD_Life_Left" | awk '{print $$10}')
  echo $value
  exit
elif [[ $device_model == "ST1000DM003-1CH162" ]]
then
  value=$(sudo /usr/sbin/smartctl -a /dev/$disk | grep "Load_Cycle_Count" | awk '{print $$10}')
  echo $value
  exit
else
  echo "Not value for disk"
  exit
fi