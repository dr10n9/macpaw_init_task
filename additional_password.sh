
#this code finds 3 parts of password  
quantity=$(cmd < /app/codes | wc -l)
for((i=1;i<=quantity;i++))
do
	arr[i]=$(head -$i codes | tail -1)
	arr2[i]=$(cmd < /var/log/nginx/old.log | grep -c ${arr[i]})
done

max=${arr[1]}
for((i=1;i<=quantity;i++))
do
	if((arr2[i]>max)); then
		max=${arr[i]}
        fi
done
part1=$max

part2=$(cmd < /var/log/nginx/old.log | grep -c '=8.8.8.8')
part3=$(curl -I hint.macpaw.io | grep 'ETag');part3=$(cmd < ${part3:7:2})
pass=$((part1+part2+part3))
echo $pass > /app/pass
