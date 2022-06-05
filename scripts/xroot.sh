#!/bin/sh
export DISPLAY=:0
while true;
do
	DATE=$(/bin/date +"%a %b %d %H:%M")
	BATT=$(/usr/bin/cat /sys/class/power_supply/BAT0/capacity)
	STAT=$(/usr/bin/cat /sys/class/power_supply/BAT0/status)
	MEM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
	DISK=$(df -h | awk '$NF=="/home"{printf "%d/%dGB (%s)\n", $3,$2,$5}')
	CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}')	
	ROOT="| $BATT% (${STAT:0:3}) | $MEM | $DATE | $DISK | $CPU_LOAD |"
	xsetroot -name "$ROOT"
	sleep 1
done
