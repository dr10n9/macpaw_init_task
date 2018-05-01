#!/bin/bash
quantity=$(cat codes | wc -l)
for((i=1;i<=quantity;i++))
do
	arr[i]=$(head -$i codes | tail -1)
	arr2[i]=$(cat /var/log/nginx/old.log | grep ${arr[i]} | wc -l)
done

max=${arr[1]}
for((i=1;i<=quantity;i++))
do
	if((arr2[i]>$max)); then
		max=${arr[i]}
        fi
done
part1=$max

part2=$(cat /var/log/nginx/old.log | grep '=8.8.8.8' | wc -l)
part3=$(curl -I hint.macpaw.io | grep 'ETag');part3=$(echo ${part3:7:2})
pass=$(($part1+$part2+$part3))
echo $pass > pass
