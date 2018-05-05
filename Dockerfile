FROM macpaw/internship

COPY . /app
RUN apt update -y
RUN apt install -y logrotate
RUN /app/script.sh

EXPOSE 80
