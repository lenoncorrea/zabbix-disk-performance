#!/usr/bin/python
import os
import json
import re

disks = []
def remove_number(devices):
    for device in devices:
        r = re.compile(r'([0-9])|([\-])')
        device = r.sub('',device)
        if device not in disks:
            disks.append(device)
    return(disks)

if __name__ == "__main__":
    skippable = ("sr", "loop", "ram","dm")
    devices = (device for device in os.listdir("/sys/class/block")
               if not any(ignore in device for ignore in skippable))
    devices = remove_number(devices)
    file = open("/etc/zabbix/zabbix_agentd.d/zabbix-disk-performance/disks.txt","w")
    file.write(''+devices+'')
    file.close()
    # data = [{"{#DEVICENAME}": device} for device in devices]
    # print(json.dumps({"data": data}, indent=4))