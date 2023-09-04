#!/bin/bash
disk="sda"
path="/var/log/iostat.log"
tmp="/var/log/iostat.tmp"
while :
do
rm $tmp 2> /dev/null
date=$(date | awk '{print $3,$2,$4}')
iostat -yh /dev/$disk 1 > $tmp &
sleep 2
kill %1
tps=$(cat $tmp | grep $disk | awk '{print $1}' | sed -E "s/\..+//")
rs=$(cat $tmp | grep $disk | awk '{print $2}')
ws=$(cat $tmp | grep $disk | awk '{print $3}')
echo "$date  tps = $tps  read/s = $rs  write/s = $ws" >> $path
cat $path | tail -n 1
rm $tmp
sleep 5
done