#!/bin/bash

TIME_VAL=$(date +"%H:%M")
HOST_VAL=$(hostname)

if [ "$(uname)" == "Darwin" ]; then
	IOSTAT=$(iostat 1 2 | tail -n 1)
	VM_STATE=$(vm_stat -c 1 1 | tail -n 1)
	MAIN_MEMORY=$(echo $VM_STATE | awk '{ print ($1+$4)*4096; }' | gnumfmt --to=iec)
	SWAP_MEMORY=$(sysctl -a | grep 'vm.swapusage' | awk '{ print $10*1024*1024; }' | gnumfmt --to=iec)

	MEM_VAL="mem:${MAIN_MEMORY}  swp:${SWAP_MEMORY}"
	CPU_VAL=$(echo $IOSTAT | awk "{ printf(\"cpu:%d/%d/%d\", \$7, \$8, \$9) }")
	DISK_VAL="$(echo $IOSTAT | awk '{ print "transfer:" $3 "M"; }')  disk:$(df -h | /usr/bin/grep '/$' | awk '{ print $4; }')"
else
	VMSTAT=$(vmstat 1 2 | tail -n 1)
	MAIN_MEMORY=$(cat /proc/meminfo | grep -e 'MemFree' | awk -v RS="" '{ print $2*1024; }' | numfmt --to=iec)
	SWAP_MEMORY=$(cat /proc/meminfo | grep -e 'SwapFree' | awk -v RS="" '{ print $2*1024; }' | numfmt --to=iec)

	MEM_VAL="mem:${MAIN_MEMORY}  swp:${SWAP_MEMORY}"
	CPU_VAL=$(echo $VMSTAT | awk "{ printf(\"cpu:%d/%d/%d/%d\", \$13, \$14, \$15, \$16) }")
	DISK_VAL="$(echo $VMSTAT | awk '{ print "read:" $9 "k  write:" $10 "k"; }')  disk:$(df -h | /bin/grep '/$' | awk '{ print $4; }')"
fi

#HOST_VAL=$(vpn status-line)
if [ "${MEM_VAL}" = "" ]; then
	MEM_VAL="<No statistics available>"
fi

echo "│  ${DISK_VAL}  │  ${MEM_VAL}  │  ${CPU_VAL}  │  ${TIME_VAL}  │  ${HOST_VAL}  "
