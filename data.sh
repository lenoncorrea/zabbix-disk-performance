#!/bin/bash

while read line
do
  retorno=$("cat /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/$line")
  echo $retorno
done < /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/disks.txt