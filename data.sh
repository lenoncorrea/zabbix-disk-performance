#!/bin/bash

while read line
do
  disk=$line
  data=$(cat /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/$disk)
  echo $data
done < /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/disks.txt