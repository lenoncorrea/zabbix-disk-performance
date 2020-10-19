#!/bin/bash

disk=$1
data=$(cat /etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/$disk)
echo $data
