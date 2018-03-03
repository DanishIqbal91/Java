#!/bin/sh

#Bash Script to clear cached memory on  Linux

#Note, we are using "echo 3", but it is not recommended in production instead use "echo 1"
#echo 1 for for Freeing Up the Page Cache
#echo 3 for Freeing Up the Page Cache, Dentries and Inodes


freemem_before=`cat /proc/meminfo | grep MemFree | tr -s ' ' | cut -d ' ' -f2`
freemem_before=`echo "$freemem_before/1024.0" | bc`
cachedmem_before=`cat /proc/meminfo | grep "^Cached" | tr -s ' ' | cut -d ' ' -f2`
cachedmem_before=`echo "$cachedmem_before/1024.0" | bc`

echo  "This At the moment you have $cachedmem_before MiB cached and $freemem_before MiB free memory."

#sudo sync
echo "sync; echo 3 > /proc/sys/vm/drop_caches" | sudo su
#echo "echo 3 > /proc/sys/vm/drop_caches" | sudo su
freemem_after=`cat /proc/meminfo | grep MemFree | tr -s ' ' | cut -d ' ' -f2`
freemem_after=`echo "$freemem_after/1024.0" | bc`

echo  "This freed `echo "$freemem_after - $freemem_before" | bc` MiB, so now you have $freemem_after MiB of free RAM."
