#!/bin/bash
path="/var/log/top-metrics.log"
trigger="20"
while :
do
date=$(date | awk '{print $3,$2,$4}')
top=$(top -bn1)
ucpu=$(printf "%s\n" "${top[@]}" | awk '/Cpu/ { print $2}')
scpu=$(printf "%s\n" "${top[@]}" | awk '/Cpu/ { print $4}')
run=$(printf "%s\n" "${top[@]}" | awk '/running/ { print $4}')
total=$(printf "%s\n" "${top[@]}" | awk '/running/ { print $2}')
users=$(printf "%s\n" "${top[@]}" | awk '/user/ { print $8}')
umem=$(printf "%s\n" "${top[@]}" | awk '/MiB Mem/ {print $8}')
tmem=$(printf "%s\n" "${top[@]}" | awk '/MiB Mem/ {print $4}')
uswap=$(printf "%s\n" "${top[@]}" | awk '/MiB Swap/ {print $7}')
tswap=$(printf "%s\n" "${top[@]}" | awk '/MiB Swap/ {print $3}')
echo "$date  CPU(user): $ucpu %  CPU(system): $scpu %  Proc: $run/$total  Users: $users  MEM: $umem/$tmem MB  SWAP: $uswap/$tswap MB" >> $path
cat $path | tail -n 1
if (( $(echo "$ucpu > $trigger" | bc) )) || (( $(echo "$scpu > $trigger" | bc) ))
then
proc=$(printf "%s\n" "${top[@]}" | sed -n 8p)
name=$(echo $proc | awk '{print $12}')
time=$(echo $proc | awk '{print $11}')
cpu=$(echo $proc | awk '{print $9}')
mem=$(echo $proc | awk '{print $10}')
user=$(echo $proc | awk '{print $2}')
echo "Warning:  $date  Top Process: $name  Time: $time  CPU: $cpu %  MEM: $mem MB  User: $user" >> $path
cat /var/log/top-metrics.log | grep Warning | tail -n 1
fi
sleep 2
done