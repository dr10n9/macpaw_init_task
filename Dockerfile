FROM macpaw/internship

COPY . /app
RUN /app/script.sh

EXPOSE 80
