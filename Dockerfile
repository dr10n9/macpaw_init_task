FROM macpaw/internship

COPY . /app
RUN cat additional_password.sh >> /entrypoint.sh
RUN cat change_configs.sh >> /entrypoint.sh

EXPOSE 80
