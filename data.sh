#!/bin/bash

while read line
do
  ruturn=$("cat /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/'$line'")
done < /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/disks.txt