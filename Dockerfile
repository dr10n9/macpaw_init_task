FROM macpaw/internship

COPY . /app
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80
