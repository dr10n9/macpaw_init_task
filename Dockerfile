FROM macpaw/internship

COPY . /app
RUN cat entrypoint.sh > /entrypoint.sh

EXPOSE 80
