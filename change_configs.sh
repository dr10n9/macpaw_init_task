#updateing nginx and supervisord conig files
awk '/--ini/{gsub(/--ini/, "--callable app --ini")};{print}' /etc/supervisor/conf.d/supervisord.conf > tmp;
cat tmp > /etc/supervisor/conf.d/supervisord.conf; rm -f tmp;
cp nginx.conf /etc/nginx/conf.d/nginx.conf;
cd /app; pip install -r requirements.txt;
