#!/bin/bash
set -e

# Get the maximum upload file size for Nginx, default to 0: unlimited
USE_NGINX_MAX_UPLOAD=${NGINX_MAX_UPLOAD:-0}
# Generate Nginx config for maximum upload file size
echo "client_max_body_size $USE_NGINX_MAX_UPLOAD;" > /etc/nginx/conf.d/upload.conf

# Get the number of workers for Nginx, default to 1
USE_NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES:-1}
# Modify the number of worker processes in Nginx config
sed -i "/worker_processes\s/c\worker_processes ${USE_NGINX_WORKER_PROCESSES};" /etc/nginx/nginx.conf

# Get the listen port for Nginx, default to 80
USE_LISTEN_PORT=${LISTEN_PORT:-80}
# Modify Nignx config for listen port
if ! grep -q "listen ${USE_LISTEN_PORT};" /etc/nginx/conf.d/nginx.conf ; then
    sed -i -e "/server {/a\    listen ${USE_LISTEN_PORT};" /etc/nginx/conf.d/nginx.conf
fi

#find 3 parts of passsword to unzip additional.zip
quantity=$(cat /app/codes | wc -l)
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
echo $pass > /app/pass

#update nginx and supervisord conig files
#callable to run flask app
awk '/--ini/{gsub(/--ini/, "--callable app --ini")};{print}' /etc/supervisor/conf.d/supervisord.conf > tmp;
cat tmp > /etc/supervisor/conf.d/supervisord.conf;
rm -f tmp;
cp nginx.conf /etc/nginx/conf.d/nginx.conf;
cd /app;
#install packages from requirements.txt
pip install -r requirements.txt;
exec "$@"
