#!/bin/bash

MAIN_MEMORY=$(cat /proc/meminfo | grep -e 'MemFree' | awk -v RS="" '{ print $2*1024; }' | numfmt --to=iec)
SWAP_MEMORY=$(cat /proc/meminfo | grep -e 'SwapFree' | awk -v RS="" '{ print $2*1024; }' | numfmt --to=iec)

MEM_VAL="mem:${MAIN_MEMORY}  swp:${SWAP_MEMORY}"
CPU_VAL=$(vmstat 1 2 | tail -n 1 | awk "{ printf(\"cpu:%d/%d/%d/%d\", \$13, \$14, \$15, \$16) }")
TIME_VAL=$(date +"%H:%M")
HOST_VAL=$(hostname)
DISK_VAL="$(vmstat 1 2 | tail -n 1 | awk '{ print "read:" $9 "k  write:" $10 "k"; }')  disk:$(df -h | /bin/grep '/$' | awk '{ print $4; }')"
#HOST_VAL=$(vpn status-line)

if [ "${MEM_VAL}" = "" ]; then
	MEM_VAL="<No statistics available>"
fi

echo "│  ${DISK_VAL}  │  ${MEM_VAL}  │  ${CPU_VAL}  │  ${TIME_VAL}  │  ${HOST_VAL}  "

